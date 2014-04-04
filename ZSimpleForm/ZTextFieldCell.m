//
//  ZTextFieldCell.m
//
//  Created by Ayal Spitz on 8/7/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZTextFieldCell.h"
#import "ZFlag.h"
#import "JVFloatLabeledTextField.h"
#import "UIView+ViewSearch.h"
#import "ZFormFieldModel.h"

#import "ZEMailFormFieldModel.h"
#import "ZPasswordFormFieldModel.h"
#import "ZPhoneNumberFormFieldModel.h"
#import "ZZipcodeFormFieldModel.h"

NSString *const TextField_SecureTextAttribute = @"SecureTextAttribute";
NSString *const TextField_KeyboardTypeAttribute = @"KeyboardTypeAttribute";
NSString *const TextField_ValueAttribute = @"ValueAttribute";
NSString *const TextField_TypeAttribute = @"TypeAttribute";
NSString *const TextField_TitleAttribute = @"TitleAttribute";
NSString *const TextField_TextAlignmentAttribute = @"TextAlignmentAttribute";
NSString *const TextField_AutocorrectionTypeAttribute = @"TextField_AutocorrectionTypeAttribute";
NSString *const TextField_AutocapitalizationTypeAttribute = @"AutocapitalizationTypeAttribute";

@interface ZTextFieldCell ()
@property (nonatomic, strong) JVFloatLabeledTextField *textField;
@end

@implementation ZTextFieldCell

- (void)setup{
    [super setup];
    
    self.textField = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.textField];
}

- (void)setConstraints{
    [super setConstraints];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:8.0]];
     [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:-8.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:0.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0.0]];
}

#pragma mark - Cell Factory

- (void)configureFromField:(ZFormFieldModel *)field{
    self.textField.placeholder = field.title;
    self.textField.text = field.value;
        
    self.textField.secureTextEntry = [field.attributes[TextField_SecureTextAttribute] boolValue];
    self.textField.autocorrectionType = [field.attributes[TextField_AutocorrectionTypeAttribute] integerValue];
    self.textField.autocapitalizationType = [field.attributes[TextField_AutocapitalizationTypeAttribute] integerValue];
    
    NSNumber *value = nil;
    value = field.attributes[TextField_KeyboardTypeAttribute];
    self.textField.keyboardType = value == nil ? UIKeyboardTypeDefault : (UIKeyboardType)[value integerValue];
    
    if ((self.textField.keyboardType == UIKeyboardTypeEmailAddress) || self.textField.secureTextEntry){
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    value = field.attributes[TextField_TextAlignmentAttribute];
    if (value != nil){
        self.textField.textAlignment = (NSTextAlignment)[value integerValue];
    }
    
    [self showRequiredFlag:!field.isValid];

}

#pragma mark - ZBaseFormCell methods

- (BOOL)isEmpty{
    return (self.value.length == 0);
}

- (NSString *)value{
    return self.textField.text;
}

#pragma mark - Expose UITextField methods

- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate{
    self.textField.delegate = textFieldDelegate;
}

- (id<UITextFieldDelegate>)textFieldDelegate{
    return self.textField.delegate;
}

- (BOOL)becomeFirstResponder{
    [self.textField becomeFirstResponder];
    return YES;
}

#pragma mark - 

+ (instancetype)cellFromTextField:(UITextField *)textField{
    UIView *ancestor = [textField ancestor:3];
    if (![ancestor isKindOfClass:[ZTextFieldCell class]]){
        ancestor = nil;
    }
    return (ZTextFieldCell *)ancestor;
}

#pragma mark - 

- (NSTextAlignment)textAlignment{
    return self.textField.textAlignment;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    self.textField.textAlignment = textAlignment;
}

@end
