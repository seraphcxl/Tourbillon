//
//  DCHTTPOperation.m
//  Tourbillon
//
//  Created by Derek Chen on 13-10-16.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCHTTPOperation.h"
#import "DCCommonConstants.h"
#import "DCCommonFuncations.h"

static NSSet *sKeysImmutableWhileExecuting;
static NSSet *sKeysImmutableOnceDataReceived;

NSString * const kDCHTTPOperationErrorDomain = @"kDCHTTPOperationErrorDomain";

@interface DCHTTPOperation () {
}

// Read/write versions of public properties
@property (nonatomic, copy, readwrite)  NSURLRequest *request;

@property (nonatomic, copy, readwrite) NSURLRequest *lastRequest;
@property (nonatomic, copy, readwrite) NSHTTPURLResponse *lastResponse;
@property (nonatomic, copy, readwrite) NSData *responseBody;
// Internal properties

@property (nonatomic, strong, readwrite) NSURLConnection *connection;
@property (nonatomic, assign, readwrite) BOOL firstData;
@property (nonatomic, strong, readwrite) NSMutableData *dataAccumulator;

#if !defined(NDEBUG)
@property (nonatomic, strong, readwrite) NSTimer *debugDelayTimer;
#endif

@end

@implementation DCHTTPOperation

@synthesize request = _request;
@synthesize URL = _URL;
@synthesize acceptableStatusCodes = _acceptableStatusCodes;
@synthesize acceptableContentTypes = _acceptableContentTypes;
@synthesize authenticationDelegate = _authenticationDelegate;
#if !defined(NDEBUG)
@synthesize debugError = _debugError;
@synthesize debugDelay = _debugDelay;
#endif
@synthesize responseOutputStream = _responseOutputStream;
@synthesize defaultResponseSize = _defaultResponseSize;
@synthesize maximumResponseSize = _maximumResponseSize;
@synthesize lastRequest = _lastRequest;
@synthesize lastResponse = _lastResponse;
@synthesize responseBody = _responseBody;

@synthesize connection = _connection;
@synthesize firstData = _firstData;
@synthesize dataAccumulator = _dataAccumulator;
#if !defined(NDEBUG)
@synthesize debugDelayTimer = _debugDelayTimer;
#endif

- (id)initWithRequest:(NSURLRequest *)request {
    @synchronized(self) {
        if (!request) {
            return nil;
        }
        // Initialise some globals.
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sKeysImmutableWhileExecuting = [[NSSet alloc] initWithObjects: @"acceptableStatusCodes", @"acceptableContentTypes", @"authenticationDelegate", nil];
            sKeysImmutableOnceDataReceived = [[NSSet alloc] initWithObjects: @"responseOutputStream", @"defaultResponseSize", @"maximumResponseSize", nil];
        });
        
        // any thread
        DCAssert(request != nil);
        DCAssert([request URL] != nil);
        // Because we require an NSHTTPURLResponse, we only support HTTP and HTTPS URLs.
        DCAssert([[[[request URL] scheme] lowercaseString] isEqual:@"http"] || [[[[request URL] scheme] lowercaseString] isEqual:@"https"]);
        self = [super init];
        if (self != nil) {
#if TARGET_OS_EMBEDDED || TARGET_IPHONE_SIMULATOR
            static const NSUInteger kPlatformReductionFactor = 4;
#else
            static const NSUInteger kPlatformReductionFactor = 1;
#endif
            self.request = [request copy];
            self.defaultResponseSize = DCCalcMemorySizeFormMBToInt(1) / kPlatformReductionFactor;
            self.maximumResponseSize = DCCalcMemorySizeFormMBToInt(4) / kPlatformReductionFactor;
            self.firstData = YES;
            
            // Add a set of KVO observers that watch for clients not playing by the rules.
            DCAssert(sKeysImmutableWhileExecuting != nil);
            for (NSString * key in sKeysImmutableWhileExecuting) {
                [self addObserver:self forKeyPath:key options:0 context:&self->_connection];
            }
            DCAssert(sKeysImmutableOnceDataReceived != nil);
            for (NSString * key in sKeysImmutableOnceDataReceived) {
                [self addObserver:self forKeyPath:key options:0 context:&self->_lastResponse];
            }
        }
        return self;
    }
}

- (id)initWithURL:(NSURL *)url {
    @synchronized(self) {
        if (!url) {
            return nil;
        }
        DCAssert(url != nil);
        return [self initWithRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void)dealloc {
    do {
        @synchronized(self) {
            // Remove the observers added at init time.
            DCAssert(sKeysImmutableWhileExecuting != nil);
            for (NSString * key in sKeysImmutableWhileExecuting) {
                [self removeObserver:self forKeyPath:key];
            }
            DCAssert(sKeysImmutableOnceDataReceived != nil);
            for (NSString * key in sKeysImmutableOnceDataReceived) {
                [self removeObserver:self forKeyPath:key];
            }
            
#if ! defined(NDEBUG)
            self.debugError = nil;
            [self.debugDelayTimer invalidate];
            self.debugDelayTimer = nil;
#endif
            // any thread
            self.request = nil;
            self.acceptableStatusCodes = nil;
            self.acceptableContentTypes = nil;
            self.responseOutputStream = nil;
            DCAssert(self.connection == nil); // should have been shut down by now
            self.dataAccumulator = nil;
            self.lastRequest = nil;
            self.lastResponse = nil;
        }
    } while (NO);
}

// Our API contract states that you're not allowed to change many of the readwrite
// properties at certain points in time.  In previous versions of the code I had
// custom setters to enforce these rules.  That's a painful amount of code if you
// consider that it only really benefits developers.  I've removed all those setters
// and now use KVO to watch for changes and complain if I see any.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    do {
        if (context == &self->_connection) {
            DCAssert([sKeysImmutableWhileExecuting containsObject:keyPath]);
            DCAssert(object == self);
            if (self.state == kDCRunLoopOperationStateExecuting) {
                NSLog(@"*** Programmer Error *** Changed key %@ of %@ while executing", keyPath, self);
                DCAssert(NO);
            }
        } else if (context == &self->_lastResponse) {
            DCAssert([sKeysImmutableOnceDataReceived containsObject:keyPath]);
            DCAssert(object == self);
            if (self.dataAccumulator != nil) {
                NSLog(@"*** Programmer Error *** Changed key %@ of %@ after data received", keyPath, self);
                DCAssert(NO);
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } while (NO);
}

- (NSURL *)URL {
    return [self.request URL];
}

- (BOOL)isStatusCodeAcceptable {
    BOOL result = NO;
    do {
        NSIndexSet *acceptableStatusCodes = nil;
        NSInteger statusCode = 0;
        
        DCAssert(self.lastResponse != nil);
        
        acceptableStatusCodes = self.acceptableStatusCodes;
        if (acceptableStatusCodes == nil) {
            acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
        }
        DCAssert(acceptableStatusCodes != nil);
        
        statusCode = [self.lastResponse statusCode];
        result = (statusCode >= 0) && [acceptableStatusCodes containsIndex: (NSUInteger) statusCode];
    } while (NO);
    return result;
}

- (BOOL)isContentTypeAcceptable {
    BOOL result = NO;
    do {
        NSString *contentType = nil;
        
        DCAssert(self.lastResponse != nil);
        contentType = [self.lastResponse MIMEType];
        result = (self.acceptableContentTypes == nil) || ((contentType != nil) && [self.acceptableContentTypes containsObject:contentType]);
    } while (NO);
    return result;
}

// Called by QRunLoopOperation when the operation starts.  This kicks of an
// asynchronous NSURLConnection.
- (void)operationDidStart {
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(self.state == kDCRunLoopOperationStateExecuting);
        
        DCAssert(self.defaultResponseSize > 0);
        DCAssert(self.maximumResponseSize > 0);
        DCAssert(self.defaultResponseSize <= self.maximumResponseSize);
        
        DCAssert(self.request != nil);
        
        DCAssert(self.connection == nil);
        if ([self isCancelled]) {
            [self finishWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
        } else {
            // If a debug error is set, apply that error rather than running the connection.
#if ! defined(NDEBUG)
            if (self.debugError != nil) {
                [self finishWithError:self.debugError];
                return;
            }
#endif
            
            // Create a connection that's scheduled in the required run loop modes.
            self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
            DCAssert(self.connection != nil);
            
            for (NSString *mode in self.actualRunLoopModes) {
                [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:mode];
            }
            
            [self.connection start];
        }
    } while (NO);
}

// Called by QRunLoopOperation when the operation has finished.  We
// do various bits of tidying up.
- (void)operationWillFinish {
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(self.state == kDCRunLoopOperationStateExecuting);
        
        // I can't think of any circumstances under which the debug delay timer
        // might still be running at this point, but add an DCAssert just to be sure.
#if ! defined(NDEBUG)
        DCAssert(self.debugDelayTimer == nil);
#endif
        
        [self.connection cancel];
        self.connection = nil;
        
        // If we have an output stream, close it at this point.  We might never
        // have actually opened this stream but, AFAICT, closing an unopened stream
        // doesn't hurt.
        if (self.responseOutputStream != nil) {
            [self.responseOutputStream close];
        }
    } while (NO);
}

// We override -finishWithError: just so we can handle our debug delay.
- (void)finishWithError:(NSError *)error {
    // If a debug delay was set, don't finish now but rather start the debug delay timer
    // and have it do the actual finish.  We clear self.debugDelay so that the next
    // time this code runs its doesn't do this again.
    do {
#if ! defined(NDEBUG)
        if (self.debugDelay > 0.0) {
            DCAssert(self.debugDelayTimer == nil);
            self.debugDelayTimer = [NSTimer timerWithTimeInterval:self.debugDelay target:self selector:@selector(debugDelayTimerDone:) userInfo:self.error repeats:NO];
            DCAssert(self.debugDelayTimer != nil);
            for (NSString *mode in self.actualRunLoopModes) {
                [[NSRunLoop currentRunLoop] addTimer:self.debugDelayTimer forMode:mode];
            }
            self.debugDelay = 0.0;
            break;
        }
#endif
        
        [super finishWithError:error];
    } while (NO);
}

#if ! defined(NDEBUG)
- (void)debugDelayTimerDone:(NSTimer *)timer {
    do {
        NSError *error = nil;
        
        DCAssert(timer == self.debugDelayTimer);
        
        error = [timer userInfo];
        DCAssert((error == nil) || [error isKindOfClass:[NSError class]]);
        
        [self.debugDelayTimer invalidate];
        self.debugDelayTimer = nil;
        
        [self finishWithError:error];
    } while (NO);
    
}
#endif

@end

@implementation DCHTTPOperation (NSURLConnectionDelegate)

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    BOOL result = NO;
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(connection == self.connection);
#pragma unused(connection)
        DCAssert(protectionSpace != nil);
#pragma unused(protectionSpace)
        
        result = NO;
        if (self.authenticationDelegate != nil) {
            result = [self.authenticationDelegate httpOperation:self canAuthenticateAgainstProtectionSpace:protectionSpace];
        }
    } while (NO);
    return result;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(connection == self.connection);
#pragma unused(connection)
        DCAssert(challenge != nil);
#pragma unused(challenge)
        
        if (self.authenticationDelegate != nil) {
            [self.authenticationDelegate httpOperation:self didReceiveAuthenticationChallenge:challenge];
        } else {
            if ([challenge previousFailureCount] == 0) {
                [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
            } else {
                [[challenge sender] cancelAuthenticationChallenge:challenge];
            }
        }
    } while (NO);
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    NSURLRequest *result = nil;
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(connection == self.connection);
#pragma unused(connection)
        DCAssert((response == nil) || [response isKindOfClass:[NSHTTPURLResponse class]]);
        
        self.lastRequest  = request;
        self.lastResponse = (NSHTTPURLResponse *)response;
        result = request;
    } while (NO);
    return result;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(connection == self.connection);
#pragma unused(connection)
        DCAssert([response isKindOfClass:[NSHTTPURLResponse class]]);
        
        self.lastResponse = (NSHTTPURLResponse *)response;
        
        // We don't check the status code here because we want to give the client an opportunity
        // to get the data of the error message.  Perhaps we /should/ check the content type
        // here, but I'm not sure whether that's the right thing to do.
    } while (NO);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    BOOL success = YES;
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(connection == self.connection);
#pragma unused(connection)
        DCAssert(data != nil);
        
        // If we don't yet have a destination for the data, calculate one.  Note that, even
        // if there is an output stream, we don't use it for error responses.
        if (self.firstData) {
            DCAssert(self.dataAccumulator == nil);
            
            if ((self.responseOutputStream == nil) || ! self.isStatusCodeAcceptable) {
                
                DCAssert(self.dataAccumulator == nil);
                
                long long length = [self.lastResponse expectedContentLength];
                if (length == NSURLResponseUnknownLength) {
                    length = (long long) self.defaultResponseSize; // safe assuming that (long long) is bigger than (long)
                }
                if (length <= (long long) self.maximumResponseSize) {
                    self.dataAccumulator = [NSMutableData dataWithCapacity:(NSUInteger)length];
                } else {
                    [self finishWithError:[NSError errorWithDomain:kDCHTTPOperationErrorDomain code:kDCHTTPOperationErrorResponseTooLarge userInfo:nil]];
                    success = NO;
                }
            }
            
            // If the data is going to an output stream, open it.
            if (success) {
                if (self.dataAccumulator == nil) {
                    DCAssert(self.responseOutputStream != nil);
                    [self.responseOutputStream open];
                }
            }
            
            self.firstData = NO;
        }
        
        // Write the data to its destination.
        if (success) {
            if (self.dataAccumulator != nil) {
                if (([self.dataAccumulator length] + [data length]) <= self.maximumResponseSize) {
                    [self.dataAccumulator appendData:data];
                } else {
                    [self finishWithError:[NSError errorWithDomain:kDCHTTPOperationErrorDomain code:kDCHTTPOperationErrorResponseTooLarge userInfo:nil]];
                }
            } else {
                NSUInteger dataOffset = 0;
                NSUInteger dataLength = 0;
                const uint8_t *dataPtr = nil;
                NSError *error = nil;
                NSInteger bytesWritten = 0;
                
                DCAssert(self.responseOutputStream != nil);
                
                dataOffset = 0;
                dataLength = [data length];
                dataPtr = [data bytes];
                error = nil;
                do {
                    if (dataOffset == dataLength) {
                        break;
                    }
                    bytesWritten = [self.responseOutputStream write:&dataPtr[dataOffset] maxLength:dataLength - dataOffset];
                    if (bytesWritten <= 0) {
                        error = [self.responseOutputStream streamError];
                        if (error == nil) {
                            error = [NSError errorWithDomain:kDCHTTPOperationErrorDomain code:kDCHTTPOperationErrorOnOutputStream userInfo:nil];
                        }
                        break;
                    } else {
                        dataOffset += (NSUInteger)bytesWritten; // safe because bytesWritten is positive
                    }
                } while (YES);
                
                if (error != nil) {
                    [self finishWithError:error];
                }
            }
        }
    } while (NO);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(connection == self.connection);
#pragma unused(connection)
        
        DCAssert(self.lastResponse != nil);
        
        // Swap the data accumulator over to the response data so that we don't trigger a copy.
        DCAssert(self.responseBody == nil);
        self.responseBody = [self->_dataAccumulator copy];
        self.dataAccumulator = nil;
        
        if (!self.isStatusCodeAcceptable) {
            [self finishWithError:[NSError errorWithDomain:kDCHTTPOperationErrorDomain code:self.lastResponse.statusCode userInfo:nil]];
        } else if (!self.isContentTypeAcceptable) {
            [self finishWithError:[NSError errorWithDomain:kDCHTTPOperationErrorDomain code:kDCHTTPOperationErrorBadContentType userInfo:nil]];
        } else {
            [self finishWithError:nil];
        }
    } while (NO);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    do {
        DCAssert(self.isActualRunLoopThread);
        DCAssert(connection == self.connection);
#pragma unused(connection)
        DCAssert(error != nil);
        
        [self finishWithError:error];
    } while (NO);
}

@end
