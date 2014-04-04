//
//  ZSimpleFormViewController.h
//
//  Created by Ayal Spitz on 11/27/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSimpleFormView.h"
#import "ZPlainButton.h"

@class ZSimpleFormViewController;
typedef void (^FormButtonBlock)(ZSimpleFormViewController *formViewController);

@class ZSimpleFormModel;

@interface ZSimpleFormViewController : UIViewController <ZFormViewDataSource, ZFormViewDelegate>

@property (nonatomic, strong) ZSimpleFormModel *formModel;
@property (nonatomic, readonly) ZSimpleFormView *formView;
@property (nonatomic, assign) UIEdgeInsets formViewInsets;

- (instancetype)initWithModel:(ZSimpleFormModel *)model;

- (void)setFormHeaderImageName:(NSString *)imageName;

- (void)addButton:(UIButton *)button;
- (ZPlainButton *)addButtonWithTitle:(NSString *)title andStyle:(ZPlainButtonStyle)style;

- (void)setButtonBlock:(FormButtonBlock)buttonBlock forButtonAtIndex:(NSUInteger)index;

- (id)valueOfFieldAtIndex:(NSUInteger)index;

- (void)startListeningForKeyboardAvoidingNotifications;
- (void)stopListeningForKeyboardAvoidingNotifications;

@end
