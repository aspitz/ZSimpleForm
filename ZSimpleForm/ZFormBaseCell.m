//
//  ZFormBaseCell.m
//
//  Created by Ayal Spitz on 10/24/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZFormBaseCell.h"
#import "ZFlag.h"

@interface ZFormBaseCell ()
@property (nonatomic, strong) ZFlag *requiredFlag;
@end

@implementation ZFormBaseCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    [self setup];
    [self setConstraints];
}

- (void)setup{
    self.requiredFlag = [[ZFlag alloc]init];
    self.requiredFlag.translatesAutoresizingMaskIntoConstraints = NO;
    self.requiredFlag.hidden = YES;
    [self.contentView addSubview:self.requiredFlag];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setConstraints{
    [self.contentView removeConstraints:self.contentView.constraints];

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.requiredFlag
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:0.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.requiredFlag
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0
                                                                  constant:0.0]];
}

#pragma mark - Required flag methods

- (void)showRequiredFlag:(BOOL)show{
    self.requiredFlag.hidden = !show;
}

- (BOOL)isRequiredFlagVisible{
    return !self.requiredFlag.hidden;
}

#pragma mark - Cell state methods

- (BOOL)isEmpty{
    return YES;
}

- (NSString *)value{
    return nil;
}

#pragma mark - Cell Factory

+ (instancetype)cellFromDictionary:(NSDictionary *)srcDictionary{
    id cell = [[[self class] alloc]init];
    [cell setFromDictionary:srcDictionary];
    
    return cell;
}

- (void)setFromDictionary:(NSDictionary *)srcDictionary{
}

@end
