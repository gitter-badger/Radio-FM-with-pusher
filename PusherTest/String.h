//
//  String.h
//  Sunflower
//
//  Created by Rusznyák Gábor on 2013.04.14..
//  Copyright (c) 2013 Sunflower Software Management Kft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilities)

- (BOOL) isURL;
- (NSArray *)split:(NSString *)separator;
- (NSString *)replace:(NSString *)string1 with:(NSString *)string2;
- (BOOL)contains:(NSString *)string;
- (NSString *)trim;
- (NSString *)trimAll;
- (NSString *)stripTags;
- (NSString *)htmlDecode;
- (NSString *)urlEncode;
- (NSString *)addInt:(int)intNum;
- (NSString *)addFloat:(float)floatNum;
- (NSString *)addString:(NSString *)string;
- (NSString *)addPath:(NSString *)string;
- (NSString *)substring:(int)from length:(int)length;
- (NSURL *)toURL;
- (int)indexOf:(NSString *)string;
- (int)indexOf:(NSString *)string from:(int)position;
- (void)log;
- (float)textWidth:(UIFont *)font;
- (float)textHeight:(UIFont *)font;
- (float)textHeight:(float)width font:(UIFont *)font;

+ (NSString *)new:(NSString *)string;

@end