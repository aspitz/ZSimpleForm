//
//  ZSimpleFormView.m
//
//  Created by Ayal Spitz on 11/22/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZSimpleFormView.h"
#import "ZSimpleFormFieldModel.h"
#import "ZTextFieldCell.h"
#import "ZFormBaseCell.h"
#import "ZPlainButton.h"
#import "TPKeyboardAvoidingScrollView+Utilities.h"

@interface ZButtonView : UIView
@property (nonatomic, strong) NSMutableArray *buttons;
- (void)addButton:(UIButton *)button withTarget:(id)target;
- (NSUInteger)indexOfButton:(UIButton *)button;
@end

@interface ZSimpleFormView () <UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ZSimpleFormView

- (id)init{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.textAlignment = NSTextAlignmentCenter;
    
    // build the form table view
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.scrollEnabled = NO;
    [self addSubview:self.tableView];
    
    // register the simple text field cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UI_TABLE_VIEW_CELL"];
    [self.tableView registerClass:[ZTextFieldCell class] forCellReuseIdentifier:@"SIMPLE_TEXT_FIELD_CELL"];
    
    // set view constraints
    [self addSubview:self.tableView];
    [self reviseConstraints];
}

#pragma mark - Update constraints

- (void)reviseConstraints{
    [self removeConstraints:self.constraints];
    
    NSMutableDictionary *viewDictionary = [NSMutableDictionary dictionary];
    NSMutableString *visualFormat = [[NSMutableString alloc]init];
    
    [visualFormat appendFormat:@"V:|-(==%f)-", self.insets.top];
    
    if (self.headerView != nil){
        [viewDictionary addEntriesFromDictionary:@{@"headerView":self.headerView}];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0.0]];
        [visualFormat appendString:@"[headerView]"];
    }
    
    if (self.tableView != nil){
        CGFloat width = 320.0 - (self.insets.left + self.insets.right);
        NSString *localVisualFormat = [NSString stringWithFormat:@"H:|-%f-[tableView(>=%f)]-%f-|",
                                       self.insets.left, width, self.insets.right];
        
        [viewDictionary addEntriesFromDictionary:@{@"tableView":self.tableView}];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:localVisualFormat
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        [visualFormat appendString:@"[tableView"];
        NSInteger numberOfRows = [self.tableView numberOfRowsInSection:0];
        if (numberOfRows != 0){
            [visualFormat appendFormat:@"(==%f)", numberOfRows * 44.0];
        }
        [visualFormat appendString:@"]"];
    }
    
    if (self.footerView != nil){
        NSString *localVisualFormat = [NSString stringWithFormat:@"H:|-%f-[footerView]-%f-|", self.insets.left, self.insets.right];

        [viewDictionary addEntriesFromDictionary:@{@"footerView":self.footerView}];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:localVisualFormat
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
        [visualFormat appendString:@"[footerView]"];
    }

    [visualFormat appendFormat:@"-(==%f)-|", self.insets.bottom];

    if (viewDictionary.count != 0){
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:visualFormat
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:viewDictionary]];
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRowsInSection = 0;
    
    if ([self.dataSource respondsToSelector:@selector(zFormView:numberOfRowsInSection:)]){
        numberOfRowsInSection = [self.dataSource zFormView:self numberOfRowsInSection:section];
    }
    
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kDefaultCellIdentifier = @"UI_TABLE_VIEW_CELL";
    static NSString *kSimpleTextCellIdentifier =  @"SIMPLE_TEXT_FIELD_CELL";

    ZFormFieldModel *field = [self.dataSource zFormView:self fieldForIndexPath:indexPath];
    NSString *cellIdentifier = nil;
    
    if ([field isKindOfClass:[ZSimpleFormFieldModel class]]){
        cellIdentifier = kSimpleTextCellIdentifier;
    } else {
        cellIdentifier = kDefaultCellIdentifier;
    }
    
    ZTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textAlignment = self.textAlignment;
    cell.textFieldDelegate = self;

    [cell configureFromField:field];
    
    return cell;
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL shouldChangeCharacters = YES;
    
    NSMutableString *newString = [NSMutableString stringWithString:textField.text];
    [newString replaceCharactersInRange:range withString:string];
    
    // If the user has pressed return ...
    if ((string.length == 1) && ([string characterAtIndex:0] == '\n')){
        // ... dont add the return character to the textfield
        shouldChangeCharacters = NO;
    } else {
        ZTextFieldCell *cell = [ZTextFieldCell cellFromTextField:textField];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

        // ... update the value of the field
        if ([self.dataSource respondsToSelector:@selector(zFormView:setValue:ofFieldAtIndexPath:)]){
            [self.dataSource zFormView:self setValue:newString ofFieldAtIndexPath:indexPath];
        }

        // ... let the delegate know we edited the field
        if ([self.delegate respondsToSelector:@selector(zFormView:didEditFieldAtIndexPath:)]){
            [self.delegate zFormView:self didEditFieldAtIndexPath:indexPath];
        }
    }
    
    return shouldChangeCharacters;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    BOOL shouldReturn = YES;
    // Figure out which cell is responsable for the textField
    ZTextFieldCell *cell = [ZTextFieldCell cellFromTextField:textField];
    // Figure out where this cell is
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // Check if we're at the last cell of this form
    if (indexPath.row + 1 < [self.tableView numberOfRowsInSection:0]){
        // if we're not at the bottom then advance to the next text field
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
        ZTextFieldCell *cell = (ZTextFieldCell *)[self.tableView cellForRowAtIndexPath:nextIndexPath];
        [cell becomeFirstResponder];
        shouldReturn = NO;
    } else {
        // otherwise we should let the deleget know we're done
        if ([self.delegate respondsToSelector:@selector(zFormViewHasReturnedFromLastField:)]){
            [self.delegate zFormViewHasReturnedFromLastField:self];
        }
    }
    
    return shouldReturn;
}

#pragma mark - DataSource methods

- (void)setDataSource:(id<ZFormViewDataSource>)dataSource{
    _dataSource = dataSource;
    [self.tableView reloadData];
    [self reviseConstraints];
}

#pragma mark -

- (void)setInsets:(UIEdgeInsets)contentInset{
    _insets = contentInset;
    [self reviseConstraints];
}

#pragma mark - Header/Footer view methods

- (void)setHeaderView:(UIView *)headerView{
    [_headerView removeFromSuperview];
    _headerView = headerView;
    _headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_headerView];
    
    [self reviseConstraints];
}

- (void)setFooterView:(UIView *)footerView{
    [_footerView removeFromSuperview];
    _footerView = footerView;
    [self addSubview:_footerView];
    
    [self reviseConstraints];
}

#pragma mark -

- (CGSize)intrinsicContentSize{
    CGFloat height = self.insets.top;
    height += self.headerView.frame.size.height;
    height += [self.tableView numberOfRowsInSection:0] * 44.0;
    
    CGSize footerViewIntrinsicContentSize = [self.footerView intrinsicContentSize];
    if (footerViewIntrinsicContentSize.height != UIViewNoIntrinsicMetric ){
        height += footerViewIntrinsicContentSize.height;
    }

    height += self.insets.bottom;
    
    CGFloat width = UIViewNoIntrinsicMetric;
    if (self.headerView != nil){
        width = self.headerView.frame.size.width;
    }
    
    return CGSizeMake(width, height);
}

#pragma mark - Border methods

- (CGFloat)borderWidth{
    return self.tableView.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.tableView.layer.borderWidth = borderWidth;
}

- (CGColorRef)borderColor{
    return self.tableView.layer.borderColor;
}

- (void)setBorderColor:(CGColorRef)borderColor{
    self.tableView.layer.borderColor = borderColor;
}

- (CGFloat)cornerRadius{
    return self.tableView.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.tableView.layer.cornerRadius = cornerRadius;
}

#pragma mark - 

- (void)showRequiredFlag:(BOOL)showFlag forFieldAtIndex:(NSUInteger)fieldIndex{
    NSIndexPath *fieldIndexPath = [NSIndexPath indexPathForRow:fieldIndex inSection:0];
    ZTextFieldCell *cell = (ZTextFieldCell *)[self.tableView cellForRowAtIndexPath:fieldIndexPath];
    [cell showRequiredFlag:showFlag];
}

- (void)addButton:(UIButton *)button{
    if (self.footerView == nil){
        self.footerView = [[ZButtonView alloc]init];
    }
    
    [((ZButtonView *)self.footerView) addButton:button withTarget:self];
    [self reviseConstraints];
}

- (IBAction)buttonPress:(UIButton *)srcButton{
    NSUInteger buttonIndex = [((ZButtonView *)self.footerView) indexOfButton:srcButton];
    
    if ([self.delegate respondsToSelector:@selector(zFormView:clickedButtonAtIndex:)]){
        [self.delegate zFormView:self clickedButtonAtIndex:buttonIndex];
    }
}

#pragma mark - 

- (void)reloadTableViewData{
    [self.tableView reloadData];
}

- (void)reloadData{
    [self.tableView reloadData];
    [self reviseConstraints];
}

- (void)reloadFieldAtIndexPath:(NSIndexPath *)indexPath{
    ZTextFieldCell *cell = (ZTextFieldCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    ZFormFieldModel *field = [self.dataSource zFormView:self fieldForIndexPath:indexPath];
    
    [cell showRequiredFlag:!field.isValid];
    [cell setNeedsDisplay];
}

- (void)startListeningForKeyboardAvoidingNotifications{
    [self startListeningForNotifications];
}

- (void)stopListeningForKeyboardAvoidingNotifications{
    [self stopListentningForNotifications];
    
}

@end

#pragma mark - ZButtonView class

@implementation ZButtonView

- (id)init{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.buttons = [NSMutableArray array];
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)reviseConstraints{
    [self removeConstraints:self.constraints];
    
    NSMutableDictionary *viewDictionary = [NSMutableDictionary dictionary];
    NSMutableString *verticalVisualFormat = [@"V:|-(==8)-" mutableCopy];
    
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NSString *viewName = [NSString stringWithFormat:@"button%lu", (unsigned long)idx];
        viewDictionary[viewName] = button;
        NSString *visualFormat = [NSString stringWithFormat:@"H:|[%@]|",viewName];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
        [verticalVisualFormat appendFormat:@"[%@]",viewName];
        if (idx != (self.buttons.count - 1)){
            [verticalVisualFormat appendString:@"-(==2)-"];
        }
    }];

    [verticalVisualFormat appendString:@"|"];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalVisualFormat
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:viewDictionary]];
}

- (void)addButton:(UIButton *)button withTarget:(id)target{
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.buttons addObject:button];
    [self addSubview:button];
    
    if (button.allTargets.count == 0){
        [button addTarget:target action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self reviseConstraints];
}

- (NSUInteger)indexOfButton:(UIButton *)button{
    return [self.buttons indexOfObject:button];
}

- (CGSize)intrinsicContentSize{
    __block CGFloat height = 8.0;
    
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop){
        CGSize buttonIntrinsicContentSize = [button intrinsicContentSize];
        if (buttonIntrinsicContentSize.height != UIViewNoIntrinsicMetric ){
            height += buttonIntrinsicContentSize.height;
        }
        if (idx != (self.buttons.count - 1)){
            height += 2;
        }
    }];
    
    return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

@end
