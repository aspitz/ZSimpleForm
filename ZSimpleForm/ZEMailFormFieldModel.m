//
//  ZEMailFormFieldModel.m
//
//  Created by Ayal Spitz on 2/23/14.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "ZEMailFormFieldModel.h"
#import "ZTextFieldCell.h"

@implementation ZEMailFormFieldModel

- (instancetype)init{
    self = [super initWithTitle:@"eMail"];
    if (self){
        self.fieldType = ZFormFieldEMailType;
        [self addAttributes:@{TextField_KeyboardTypeAttribute:@(UIKeyboardTypeEmailAddress)}];
    }
    return self;
}

@end
