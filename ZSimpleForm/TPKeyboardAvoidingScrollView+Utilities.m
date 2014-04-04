//
//  TPKeyboardAvoidingScrollView+Utilities.m
//
//  Created by Ayal Spitz on 9/7/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "TPKeyboardAvoidingScrollView+Utilities.h"

@implementation TPKeyboardAvoidingScrollView (Utilities)

- (void)startListeningForNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TPKeyboardAvoiding_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TPKeyboardAvoiding_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)stopListentningForNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
