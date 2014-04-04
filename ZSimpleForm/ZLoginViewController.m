//
//  ZLoginViewController.m
//
//  Created by Ayal Spitz on 12/7/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZLoginViewController.h"
#import "ZSimpleFormModel.h"
#import "ZFormFieldModel.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "UIAlertView+Utilities.h"
#import "NSArray+Utilities.h"

@implementation ZLoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    self.formViewInsets = UIEdgeInsetsMake(20.0, 40.0, 20.0, 40.0);
    
    [self setFormHeaderImageName:@"Banner"];
    [self addButtonWithTitle:@"Login" andStyle:ZPlainButtonStylePrimary];
    [self addButtonWithTitle:@"Sign up" andStyle:ZPlainButtonStyleSecondar];
    [self addButtonWithTitle:@"Forgot Password?" andStyle:ZPlainButtonStyleTertiary];
    
    self.formModel = [ZSimpleFormModel modelWithFields:@[ZFormFieldEMailType, ZFormFieldPasswordType]];
}

- (void)zFormView:(ZSimpleFormView *)formView clickedButtonAtIndex:(NSUInteger)index{
    [self.formView endEditing:YES];
    
    switch (index){
        case ZLoginButtonIndexLogin:
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
        [self login];
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

- (void)login{
    [SVProgressHUD showWithStatus:@"Login in" maskType:SVProgressHUDMaskTypeBlack];
    
    NSString *username = [self valueOfFieldAtIndex:ZLoginFieldIndexEMail];
    username = [username lowercaseString];
    NSString *password = [self valueOfFieldAtIndex:ZLoginFieldIndexPassword];
    
//    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (user != nil){
//                [SVProgressHUD dismiss];
//                [super zFormView:self.formView clickedButtonAtIndex:ZLoginButtonIndexLogin];
//            } else {
//                [SVProgressHUD showErrorWithStatus:@"Failed to login"];
//                [UIAlertView showAlertTitle:[NSString stringWithFormat:@"Login error (%ld)", (long)error.code] message:error.userInfo[@"error"]];
//            }
//        });
//    }];
}

@end
