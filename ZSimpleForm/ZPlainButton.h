//
//  ZPlainButton.h
//
//  Created by Ayal Spitz on 9/30/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZPlainButtonStyle){
    ZPlainButtonStylePrimary,
    ZPlainButtonStyleSecondar,
    ZPlainButtonStyleTertiary
};
@interface ZPlainButton : UIButton

@property (nonatomic, copy) void(^buttonPressBlock)(ZPlainButton *srcButton);
@property (nonatomic, assign) ZPlainButtonStyle style;

+ (instancetype)plainButtonWithTitle:(NSString *)title;

- (instancetype)initWithTitle:(NSString *)title;

- (void)setTitle:(NSString *)title;
- (void)setTextColor:(UIColor *)textColor;

@end
