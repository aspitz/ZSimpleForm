//
//  ZFlag.m
//
//  Created by Ayal Spitz on 8/13/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZFlag.h"

@implementation ZFlag

- (id)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    _intrinsicContentSize = CGSizeMake(33.0, 33.0);
}

- (CGSize)intrinsicContentSize{
    return _intrinsicContentSize;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, 0.0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextClosePath(context);
    
    [[UIColor redColor] setFill];
    CGContextFillPath(context);

    CGContextSetTextDrawingMode(context, kCGTextFill);
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    CGPoint point = CGPointMake(20.0, 0.0);
    [@"!" drawAtPoint:point withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
