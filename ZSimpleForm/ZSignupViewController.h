//
//  ZSignupViewController.h
//
//  Created by Ayal Spitz on 12/7/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZSimpleFormViewController.h"

typedef NS_ENUM(NSUInteger, ZSignupFieldIndex){
    ZSignupFieldIndexFirstName,
    ZSignupFieldIndexLastName,
    ZSignupFieldIndexEMail,
    ZSignupFieldIndexPhoneNumber,
    ZSignupFieldIndexZipcode,
    ZSignupFieldIndexPassword
};

typedef NS_ENUM(NSUInteger, ZSignupButtonIndex){
    ZSignupButtonIndexSignup,
    ZSignupButtonIndexCancel
};

@interface ZSignupViewController : ZSimpleFormViewController

@end
