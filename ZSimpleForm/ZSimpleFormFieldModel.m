//
//  ZSimpleFormFieldModel.m
//
//  Created by Ayal Spitz on 2/24/14.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "ZSimpleFormFieldModel.h"

#import "ZEMailFormFieldModel.h"
#import "ZPasswordFormFieldModel.h"
#import "ZPhoneNumberFormFieldModel.h"
#import "ZZipcodeFormFieldModel.h"

@implementation ZSimpleFormFieldModel

- (instancetype)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
    }
    return self;
}

+ (instancetype)fieldOfType:(ZFormFieldType)type{
    ZSimpleFormFieldModel *field;
    
    if (type == ZFormFieldEMailType){
        field = [ZEMailFormFieldModel fieldModel];
    } else if (type == ZFormFieldPasswordType){
        field = [ZPasswordFormFieldModel fieldModel];
    } else if (type == ZFormFieldPhoneNumberType){
        field = [ZPhoneNumberFormFieldModel fieldModel];
    } else if (type == ZFormFieldZipcodeType){
        field = [ZZipcodeFormFieldModel fieldModel];
    }
    
    return field;
}

@end
