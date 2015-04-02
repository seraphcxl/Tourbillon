//
//  NSString+DCHURLCoding.h
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DCHURLCoding)

- (NSString *)dch_urlDecodedString;
- (NSString *)dch_urlEncodedString;
- (NSDictionary *)dch_dictionaryFromQueryString;

@end
