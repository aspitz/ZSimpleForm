//
//  ZTextFieldCell.h
//
//  Created by Ayal Spitz on 8/7/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZFormBaseCell.h"
#import "ZFormFieldModel.h"

extern NSString *const TextField_SecureTextAttribute;
extern NSString *const TextField_KeyboardTypeAttribute;
extern NSString *const TextField_ValueAttribute;
extern NSString *const TextField_TypeAttribute;
extern NSString *const TextField_TitleAttribute;
extern NSString *const TextField_TextAlignmentAttribute;
extern NSString *const TextField_AutocorrectionTypeAttribute;
extern NSString *const TextField_AutocapitalizationTypeAttribute;

typedef NS_ENUM(NSUInteger, ZSimpleTextFieldCellType){
    ZSimpleTextFieldCellEMailType,
    ZSimpleTextFieldCellPasswordType,
    ZSimpleTextFieldCellZipcodeType,
    ZSimpleTextFieldCellPhoneNumberType
};

@interface ZTextFieldCell : ZFormBaseCell

@property (nonatomic, assign) id<UITextFieldDelegate> textFieldDelegate;
@property (nonatomic, readonly) NSString *value;
@property (nonatomic, assign) NSTextAlignment textAlignment;

- (BOOL)becomeFirstResponder;

+ (instancetype)cellFromTextField:(UITextField *)textField;

- (void)configureFromField:(ZFormFieldModel *)field;

@end
