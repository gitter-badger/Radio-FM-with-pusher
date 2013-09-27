//
//  View.h
//  MEKBook
//
//  Created by Rusznyák Gábor on 2013.05.17..
//  Copyright (c) 2013 Sunflower Software Management Kft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Utilities)

@property (nonatomic) float x, y, width, height;

- (float)x;
- (float)y;
- (float)width;
- (float)height;
- (void)setX:(float)x;
- (void)setY:(float)y;
- (void)setWidth:(float)width;
- (void)setHeight:(float)height;

@end
