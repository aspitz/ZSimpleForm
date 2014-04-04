//
//  ZSignupViewController2.m
//
//  Created by Ayal Spitz on 12/7/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZSignupViewController.h"
#import "ZSimpleFormModel.h"
#import "ZFormFieldModel.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "UIAlertView+Utilities.h"
#import "NSArray+Utilities.h"

@implementation ZSignupViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.formViewInsets = UIEdgeInsetsMake(20.0, 40.0, 20.0, 40.0);
    
    [self setFormHeaderImageName:@"Banner"];
    [self addButtonWithTitle:@"Sign up" andStyle:ZPlainButtonStylePrimary];
    [self addButtonWithTitle:@"Cancel" andStyle:ZPlainButtonStyleSecondar];
    
    self.formModel = [ZSimpleFormModel modelWithFields:@[@[ZFormFieldSimpleTextType, @"First Name"], @[ZFormFieldSimpleTextType, @"Last Name"], ZFormFieldEMailType, ZFormFieldPhoneNumberType, ZFormFieldZipcodeType, ZFormFieldPasswordType]];
}

- (void)zFormView:(ZSimpleFormView *)formView clickedButtonAtIndex:(NSUInteger)index{
    [self.formView endEditing:YES];
    
    switch (index){
        case ZSignupButtonIndexSignup:
            [self validateForm];
            break;
        default:
            [self.formModel clear];
            [self.formView reloadTableViewData];
            [super zFormView:formView clickedButtonAtIndex:index];
            break;
    }
}

- (void)validateForm{
    NSArray *invalidFields = [self.formModel invalidFields];
    if (invalidFields.count == 0){
        [self signup];
    } else {
        [self.formView reloadTableViewData];
        
        NSArray *fieldNames = [invalidFields arrayByEnumeratingUsingBlock:^id(ZFormFieldModel *fieldModel, NSUInteger idx, BOOL *stop) {
            return fieldModel.title;
        }];
        NSString *s = (invalidFields.count > 1) ? @"s" : @"";
        NSString *fields = [fieldNames componentsJoinedByString:@", "];
        NSString *alertString = [NSString stringWithFormat:@"Please fill in the following field%@: %@", s, fields];
        [UIAlertView showAlertTitle:nil message:alertString];
    }
}

- (void)signup{
    [SVProgressHUD showWithStatus:@"Signing up" maskType:SVProgressHUDMaskTypeBlack];
    
//    PFUser *user = [PFUser user];
//    user.username = [self valueOfFieldAtIndex:ZSignupFieldIndexEMail];
//    user.username = [user.username lowercaseString];
//    user.password = [self valueOfFieldAtIndex:ZSignupFieldIndexPassword];
//    user.email = user.username;
//    user.firstName = [self valueOfFieldAtIndex:ZSignupFieldIndexFirstName];
//    user.lastName = [self valueOfFieldAtIndex:ZSignupFieldIndexLastName];
//    user.phoneNumber = [self valueOfFieldAtIndex:ZSignupFieldIndexPhoneNumber];
//    user.zipcode = [self valueOfFieldAtIndex:ZSignupFieldIndexZipcode];
//    
//    NSError *error = [user getLocation];
//    if (error != nil){
//        [SVProgressHUD showErrorWithStatus:@"Failed to sign up"];
//        [UIAlertView showAlertTitle:[NSString stringWithFormat:@"Sign up error (%ld)", (long)error.code] message:@"Failed to locate zip code"];
//    } else {
//        BOOL success = [user signUp:&error];
//        
//        if (success){
//            [SVProgressHUD dismiss];
//            [super zFormView:self.formView clickedButtonAtIndex:ZSignupButtonIndexSignup];
//        } else {
//            [SVProgressHUD showErrorWithStatus:@"Failed to sign up"];
//            [UIAlertView showAlertTitle:[NSString stringWithFormat:@"Sign up error (%ld)", (long)error.code] message:error.userInfo[@"error"]];
//        }
//    }
}

@end
