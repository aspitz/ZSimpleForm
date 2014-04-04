//
//  ZFormFieldModel.m
//
//  Created by Ayal Spitz on 11/21/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZFormFieldModel.h"
#import "ZTextFieldCell.h"

ZFormFieldType const ZFormFieldSimpleTextType = @"ZFormFieldSimpleTextType";
ZFormFieldType const ZFormFieldEMailType = @"ZFormFieldEMailType";
ZFormFieldType const ZFormFieldPasswordType = @"ZFormFieldPasswordType";
ZFormFieldType const ZFormFieldZipcodeType = @"ZFormFieldZipcodeType";
ZFormFieldType const ZFormFieldPhoneNumberType = @"ZFormFieldPhoneNumberType";

ZFormFieldType const ZFormFieldTextType = @"ZFormFieldTextType";
ZFormFieldType const ZFormFieldTextFieldType = @"ZFormFieldTextFieldType";
ZFormFieldType const ZFormFieldDateType = @"ZFormFieldDateType";
ZFormFieldType const ZFormFieldDateRangeType = @"ZFormFieldDateRangeType";
ZFormFieldType const ZFormFieldSwitchType = @"ZFormFieldSwitchType";
ZFormFieldType const ZFormFieldMultiSelectType = @"ZFormFieldMultiSelectType";
ZFormFieldType const ZFormFieldCheckboxType = @"ZFormFieldCheckboxType";

ZFormFieldProperty const ZFormFieldDefaultValueProperty = @"ZFormFieldDefaultValueProperty";
ZFormFieldProperty const ZFormFieldDetailProperty = @"ZFormFieldDetailProperty";
ZFormFieldProperty const ZFormFieldPlaceholderProperty = @"ZFormFieldPlaceholderProperty";
ZFormFieldProperty const ZFormFieldSecretProperty = @"ZFormFieldSecretProperty";

static ValidationBlock EmptyValidationBlock = ^BOOL(ZFormFieldModel *field){
    return ([field.value length] != 0);
};

static ValidationBlock DefaultValidationBlock = ^BOOL(ZFormFieldModel *field){
    return YES;
};

@interface ZFormFieldModel ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readwrite, assign) BOOL isValid;
@end

@implementation ZFormFieldModel

#pragma mark - Init methods

- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.validationBlock = DefaultValidationBlock;
        self.title = title;
        self.value = nil;
        self.defaultValue = nil;
        self.attributes = [NSMutableDictionary dictionary];
        self.fieldType = ZFormFieldSimpleTextType;
    }
    return self;
}

+ (instancetype)fieldWithTitle:(NSString *)title{
    return [[ZFormFieldModel alloc]initWithTitle:title];
}

+ (instancetype)fieldModel{
    return [[[self class]alloc]init];
}

+ (instancetype)fieldOfType:(ZFormFieldType)type{
    return [[ZFormFieldModel alloc]init];
}

- (void)addAttributes:(NSDictionary *)attributes{
    [self.attributes addEntriesFromDictionary:attributes];
}

#pragma mark -
- (void)setValue:(NSString *)value{
    _value = value;
    self.isValid = (value == nil) ? YES : self.validationBlock(self);
}

- (void)clearValue{
    self.value = nil;
}

- (void)validate{
    self.isValid = self.validationBlock(self);
}

#pragma mark -

+ (ValidationBlock)emptyValidationBlock{
    return EmptyValidationBlock;
}

@end
