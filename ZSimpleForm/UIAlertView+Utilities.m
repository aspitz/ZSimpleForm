//
//  UIAlertView+Utilities.m
//  SitterApp
//
//  Created by Ayal Spitz on 9/14/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "UIAlertView+Utilities.h"

@implementation UIAlertView (Utilities)

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [alertView show];
}

@end
