//
//  Functions.h
//  Sunflower Ingatlan
//
//  Created by Rusznyák Gábor on 2010.05.30..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Functions : NSObject

+ (BOOL)connectedToNetwork;
+ (BOOL)connectedToNetwork:(NSString *)url;
+ (NSData *)loadDataFromURL:(NSString *)url;
+ (NSString *)loadStringFromURL:(NSString *)url;
+ (void)alert:(NSString *)message;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (NSString *)path2doc;

@end
