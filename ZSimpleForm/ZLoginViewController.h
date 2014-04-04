//
//  ZLoginViewController.h
//
//  Created by Ayal Spitz on 12/7/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZSimpleFormViewController.h"

typedef NS_ENUM(NSUInteger, ZLoginFieldIndex){
    ZLoginFieldIndexEMail,
    ZLoginFieldIndexPassword
};

typedef NS_ENUM(NSUInteger, ZLoginButtonIndex){
    ZLoginButtonIndexLogin,
    ZLoginButtonIndexSignup,
    ZLoginButtonIndexForgotPassword
};

@interface ZLoginViewController : ZSimpleFormViewController

@end
