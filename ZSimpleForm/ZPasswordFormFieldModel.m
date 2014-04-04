//
//  ZPasswordFormFieldModel.m
//
//  Created by Ayal Spitz on 2/23/14.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "ZPasswordFormFieldModel.h"
#import "ZTextFieldCell.h"

@implementation ZPasswordFormFieldModel

- (instancetype)init{
    self = [super initWithTitle:@"Password"];
    if (self){
        self.fieldType = ZFormFieldPasswordType;
        [self addAttributes:@{TextField_SecureTextAttribute:@YES}];
    }
    return self;
}

@end
