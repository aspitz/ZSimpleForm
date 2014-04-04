//
//  ZPhoneNumberFormFieldModel.m
//
//  Created by Ayal Spitz on 2/23/14.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "ZPhoneNumberFormFieldModel.h"
#import "ZTextFieldCell.h"

@implementation ZPhoneNumberFormFieldModel

- (instancetype)init{
    self = [super initWithTitle:@"Phone Number"];
    if (self){
        self.fieldType = ZFormFieldPhoneNumberType;
        [self addAttributes:@{TextField_KeyboardTypeAttribute:@(UIKeyboardTypeNumberPad)}];
    }
    return self;
}

@end
