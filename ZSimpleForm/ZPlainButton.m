//
//  ZPlainButton.m
//
//  Created by Ayal Spitz on 9/30/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZPlainButton.h"

@implementation ZPlainButton

+ (instancetype)plainButtonWithTitle:(NSString *)title{
    return [[ZPlainButton alloc]initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        [self setTitle:title];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor lightGrayColor];

        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 0.5;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

#pragma mark - Button style
- (void)setStyle:(ZPlainButtonStyle)style{
    _style = style;

    switch (style) {
        case ZPlainButtonStylePrimary:
            [self setTextColor:[UIColor whiteColor]];
            [self setBackgroundColor:self.tintColor];
            break;
        case ZPlainButtonStyleSecondar:
            [self setTextColor:[UIColor whiteColor]];
            [self setBackgroundColor:[UIColor lightGrayColor]];
            break;
        case ZPlainButtonStyleTertiary:
            [self setTextColor:self.tintColor];
            [self setBackgroundColor:[UIColor whiteColor]];
            break;
        default:
            break;
    }
}

#pragma mark - Color methods
- (void)setTextColor:(UIColor *)textColor{
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    
    if (backgroundColor == [UIColor whiteColor]){
        self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    } else {
        self.layer.borderColor = [backgroundColor CGColor];
    }
}

#pragma mark - Block methods
- (void)setButtonPressBlock:(void (^)(ZPlainButton *))buttonPressBlock{
    _buttonPressBlock = buttonPressBlock;
    [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)buttonPressed:(id)sender{
    if (self.buttonPressBlock){
        self.buttonPressBlock(self);
    }
}

@end
