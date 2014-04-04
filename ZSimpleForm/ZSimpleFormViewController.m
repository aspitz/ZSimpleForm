//
//  ZSimpleFormViewController.m
//
//  Created by Ayal Spitz on 11/27/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZSimpleFormViewController.h"
#import "ZSimpleFormView.h"
#import "ZTextFieldCell.h"
#import "ZSimpleFormModel.h"

@interface ZSimpleFormViewController ()
@property (nonatomic, strong) ZSimpleFormView *formView;
@property (nonatomic, strong) NSMutableDictionary *buttonBlockDictionary;
@end

@implementation ZSimpleFormViewController

- (instancetype)initWithModel:(ZSimpleFormModel *)model{
    self = [super init];
    if (self){
        self.formModel = model;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.formView = [[ZSimpleFormView alloc]init];
    self.formView.translatesAutoresizingMaskIntoConstraints = NO;
    self.formView.dataSource = self;
    self.formView.delegate = self;
    self.formView.cornerRadius = 8.0;
    self.formView.borderColor = [[UIColor lightGrayColor]CGColor];
    self.formView.borderWidth = 0.5;
    
    [self.view addSubview:self.formView];

    NSDictionary *viewDictionary = @{@"formView":self.formView};
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[formView]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[formView]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewDictionary]];
}

#pragma mark -
- (NSMutableDictionary *)buttonBlockDictionary{
    if (_buttonBlockDictionary == nil){
        _buttonBlockDictionary = [NSMutableDictionary dictionary];
    }
    
    return _buttonBlockDictionary;
}

#pragma mark - 
- (void)setFormModel:(ZSimpleFormModel *)formModel{
    _formModel = formModel;
    [self.formView reloadData];
}

- (void)setFormViewInsets:(UIEdgeInsets)formViewInsets{
    self.formView.insets = formViewInsets;
}

- (UIEdgeInsets)formViewInsets{
    return self.formView.insets;
}

- (void)setFormHeaderImageName:(NSString *)imageName{
    UIImage *headerImage = [UIImage imageNamed:imageName];
    UIImageView *headerImageView = [[UIImageView alloc]initWithImage:headerImage];
    self.formView.headerView = headerImageView;
}

- (void)addButton:(UIButton *)button{
    [self.formView addButton:button];
}

- (ZPlainButton *)addButtonWithTitle:(NSString *)title andStyle:(ZPlainButtonStyle)style{
    ZPlainButton *button = [ZPlainButton plainButtonWithTitle:title];
    button.style = style;
    [self.formView addButton:button];
    
    return button;
}

- (void)setButtonBlock:(FormButtonBlock)buttonBlock forButtonAtIndex:(NSUInteger)index{
    self.buttonBlockDictionary[ @(index) ] = buttonBlock;
}

#pragma mark - ZFormViewDataSource methods
- (NSInteger)zFormView:(ZSimpleFormView *)formView numberOfRowsInSection:(NSInteger)section{
    return self.formModel.count;
}

- (ZFormFieldModel *)zFormView:(ZSimpleFormView *)formView fieldForIndexPath:(NSIndexPath *)indexPath{
    return self.formModel[indexPath.row];
}

- (void)zFormView:(ZSimpleFormView *)formView setValue:(NSString *)value ofFieldAtIndexPath:(NSIndexPath *)indexPath{
    ZFormFieldModel *field = self.formModel[indexPath.row];
    field.value = value;
}

#pragma mark - ZFormViewDelegate methods
- (void)zFormView:(ZSimpleFormView *)formView didEditFieldAtIndexPath:(NSIndexPath *)indexPath{
    [self.formView reloadFieldAtIndexPath:indexPath];
}

- (void)zFormViewHasReturnedFromLastField:(ZSimpleFormView *)formView{
    [self zFormView:formView clickedButtonAtIndex:0];
}

- (void)zFormView:(ZSimpleFormView *)formView clickedButtonAtIndex:(NSUInteger)index{
    FormButtonBlock buttonBlock = self.buttonBlockDictionary[ @(index) ];
    if (buttonBlock){
        buttonBlock(self);
    }
}

- (id)valueOfFieldAtIndex:(NSUInteger)index{
    ZFormFieldModel *field = self.formModel[index];
    return field.value;
}

#pragma mark - Scroll Notifications

- (void)startListeningForKeyboardAvoidingNotifications{
    [self.formView startListeningForKeyboardAvoidingNotifications];
}

- (void)stopListeningForKeyboardAvoidingNotifications{
    [self.formView stopListeningForKeyboardAvoidingNotifications];
}

@end
