//
//  ZFormFieldModel.h
//
//  Created by Ayal Spitz on 11/21/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZFormFieldModel;

typedef NSString *ZFormFieldType;
typedef NSString *ZFormFieldProperty;

FOUNDATION_EXTERN ZFormFieldType const ZFormFieldSimpleTextType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldEMailType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldPasswordType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldZipcodeType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldPhoneNumberType;

FOUNDATION_EXTERN ZFormFieldType const ZFormFieldTextType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldTextFieldType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldDateType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldDateRangeType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldSwitchType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldMultiSelectType;
FOUNDATION_EXTERN ZFormFieldType const ZFormFieldCheckboxType;

FOUNDATION_EXTERN ZFormFieldProperty const ZFormFieldDefaultValueProperty;
FOUNDATION_EXTERN ZFormFieldProperty const ZFormFieldDetailProperty;
FOUNDATION_EXTERN ZFormFieldProperty const ZFormFieldPlaceholderProperty;
FOUNDATION_EXTERN ZFormFieldProperty const ZFormFieldSecretProperty;

typedef BOOL(^ValidationBlock)(ZFormFieldModel *formModel);

@interface ZFormFieldModel : NSObject

@property (nonatomic, assign) ZFormFieldType fieldType;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id defaultValue;
@property (nonatomic, strong) NSMutableDictionary *attributes;

@property (nonatomic, copy) ValidationBlock validationBlock;
@property (nonatomic, readonly) BOOL isValid;

- (instancetype)initWithTitle:(NSString *)title;

+ (instancetype)fieldWithTitle:(NSString *)title;
+ (instancetype)fieldOfType:(ZFormFieldType)type;

+ (instancetype)fieldModel;

- (void)addAttributes:(NSDictionary *)attributes;

- (void)clearValue;
- (void)validate;

+ (ValidationBlock)emptyValidationBlock;

@end
