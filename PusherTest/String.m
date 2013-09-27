//
//  String.m
//  Sunflower
//
//  Created by Rusznyák Gábor on 2013.04.14..
//  Copyright (c) 2013 Sunflower Software Management Kft. All rights reserved.
//

#import "String.h"

@implementation NSString (Utilities)

- (BOOL) isURL {
    return ([self hasPrefix:@"http://"]);
}

- (NSArray *)split:(NSString *)separator {
    return [self componentsSeparatedByString:separator];
}

- (NSString *)replace:(NSString *)string1 with:(NSString *)string2 {
    return [self stringByReplacingOccurrencesOfString:string1 withString:string2];
}

- (BOOL)contains:(NSString *)string {
    return ([self rangeOfString:string].location != NSNotFound);
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimAll {
    NSString *string=[self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string=[string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stripTags {
    if ([self isEqualToString:@""]) return @"";
    NSString *line=self;
    NSRange r;
    while ((r = [line rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        line = [line stringByReplacingCharactersInRange:r withString:@""];
    return [line htmlDecode];
}

- (NSString *)htmlDecode {
    NSString *line=self;
    line = [line stringByReplacingOccurrencesOfString:@"&aacute;" withString:@"á"];
    line = [line stringByReplacingOccurrencesOfString:@"&Aacute;" withString:@"Á"];
    line = [line stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
    line = [line stringByReplacingOccurrencesOfString:@"&Éacute;" withString:@"É"];
    line = [line stringByReplacingOccurrencesOfString:@"&iacute;" withString:@"í"];
    line = [line stringByReplacingOccurrencesOfString:@"&Iacute," withString:@"Í"];
    line = [line stringByReplacingOccurrencesOfString:@"&oacute;" withString:@"ó"];
    line = [line stringByReplacingOccurrencesOfString:@"&Oacute," withString:@"Ó"];
    line = [line stringByReplacingOccurrencesOfString:@"&ouml;" withString:@"ö"];
    line = [line stringByReplacingOccurrencesOfString:@"&Ouml;" withString:@"Ö"];
    line = [line stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
    line = [line stringByReplacingOccurrencesOfString:@"&Uacute," withString:@"Ú"];
    line = [line stringByReplacingOccurrencesOfString:@"&uuml;" withString:@"ü"];
    line = [line stringByReplacingOccurrencesOfString:@"&Uuml;" withString:@"Ű"];
    line = [line stringByReplacingOccurrencesOfString:@"&bdquo;" withString:@"\""];
    line = [line stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
    line = [line stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];
    line = [line stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    line = [line stringByReplacingOccurrencesOfString:@"&#0187;" withString:@"»"];
    line = [line stringByReplacingOccurrencesOfString:@"&#0171;" withString:@"«"];
    return [line trim];
}

- (NSString *)urlEncode {
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL,(CFStringRef)@"!*’();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
}

- (NSString *)addInt:(int)intNum {
    NSString *format=[NSString stringWithFormat:@"%@%%i", self];
    return [NSString stringWithFormat:format, intNum];
}

- (NSString *)addFloat:(float)floatNum {
    NSString *format=[NSString stringWithFormat:@"%@%%f", self];
    return [NSString stringWithFormat:format, floatNum];
}

- (NSString *)addString:(NSString *)string {
    return [self stringByAppendingString:string];
}

- (NSString *)addPath:(NSString *)string {
    return [self stringByAppendingPathComponent:string];
}

- (NSURL *)toURL {
	NSURL *myURL=[NSURL URLWithString:self];
    return myURL;
}

- (int)indexOf:(NSString *)string {
    return [self rangeOfString:string].location;
}

- (int)indexOf:(NSString *)string from:(int)position {
    return [self rangeOfString:string
                       options:NSCaseInsensitiveSearch
                         range:NSMakeRange(position, [self length]-position)].location;
}

- (NSString *)substring:(int)from length:(int)length {
    return [self substringWithRange:NSMakeRange(from, length)];
}

+ (NSString *)new:(NSString *)string {
    NSString *str=[[NSString alloc] initWithString:string];
    return str;
}

- (void)log {
    NSLog(@"%@", self);
}

- (float)textWidth:(UIFont *)font {
#ifdef __IPHONE_6_0
    CGSize size=[self sizeWithFont:font
                 constrainedToSize:CGSizeMake(30000, 30000)
                     lineBreakMode:NSLineBreakByWordWrapping];
#else
    CGSize size=[self sizeWithFont:font
                 constrainedToSize:CGSizeMake(30000, 30000)
                     lineBreakMode:UILineBreakModeWordWrap];
#endif
    return size.width;
}

- (float)textHeight:(UIFont *)font {
#ifdef __IPHONE_6_0
    CGSize size=[self sizeWithFont:font
                 constrainedToSize:CGSizeMake(30000, 30000)
                     lineBreakMode:NSLineBreakByWordWrapping];
#else
    CGSize size=[self sizeWithFont:font
                 constrainedToSize:CGSizeMake(30000, 30000)
                     lineBreakMode:UILineBreakModeWordWrap];
#endif
    return size.height;
}

- (float)textHeight:(float)width font:(UIFont *)font {
#ifdef __IPHONE_6_0
    CGSize size=[self sizeWithFont:font
                 constrainedToSize:CGSizeMake(width, 30000)
                     lineBreakMode:NSLineBreakByWordWrapping];
#else
    CGSize size=[self sizeWithFont:font
                 constrainedToSize:CGSizeMake(width, 30000)
                     lineBreakMode:UILineBreakModeWordWrap];
#endif
    return size.height;
}

@end
