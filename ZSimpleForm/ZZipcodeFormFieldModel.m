//
//  ZZipcodeFormFieldModel.m
//
//  Created by Ayal Spitz on 2/23/14.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "ZZipcodeFormFieldModel.h"
#import "ZTextFieldCell.h"

@implementation ZZipcodeFormFieldModel

- (instancetype)init{
    self = [super initWithTitle:@"Phone Number"];
    if (self){
        self.fieldType = ZFormFieldZipcodeType;
        [self addAttributes:@{TextField_KeyboardTypeAttribute:@(UIKeyboardTypeNumberPad)}];
    }
    return self;
}

@end
