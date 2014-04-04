//
//  ZSimpleFormView.h
//
//  Created by Ayal Spitz on 11/22/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@class ZSimpleFormView;
@class ZFormFieldModel;

@protocol ZFormViewDataSource<NSObject>
@required
- (NSInteger)zFormView:(ZSimpleFormView *)formView numberOfRowsInSection:(NSInteger)section;
- (ZFormFieldModel *)zFormView:(ZSimpleFormView *)formView fieldForIndexPath:(NSIndexPath *)indexPath;
@optional
- (void)zFormView:(ZSimpleFormView *)formView setValue:(NSString *)value ofFieldAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol ZFormViewDelegate<NSObject>
@optional
- (void)zFormView:(ZSimpleFormView *)formView didEditFieldAtIndexPath:(NSIndexPath *)indexPath;
- (void)zFormViewHasReturnedFromLastField:(ZSimpleFormView *)formView;
- (void)zFormView:(ZSimpleFormView *)formView clickedButtonAtIndex:(NSUInteger)index;
@end

@interface ZSimpleFormView : TPKeyboardAvoidingScrollView

@property (nonatomic, assign) id<ZFormViewDataSource> dataSource;
@property (nonatomic, assign) id<ZFormViewDelegate> delegate;

@property (nonatomic, assign) UIEdgeInsets insets;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGColorRef borderColor;
@property (nonatomic, assign) CGFloat cornerRadius;

- (void)showRequiredFlag:(BOOL)showFlag forFieldAtIndex:(NSUInteger)fieldIndex;
- (void)addButton:(UIButton *)button;

- (void)reloadTableViewData;
- (void)reloadData;
- (void)reloadFieldAtIndexPath:(NSIndexPath *)indexPath;

- (void)startListeningForKeyboardAvoidingNotifications;
- (void)stopListeningForKeyboardAvoidingNotifications;

@end
