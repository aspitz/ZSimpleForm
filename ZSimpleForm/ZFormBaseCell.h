//
//  ZFormBaseCell.h
//
//  Created by Ayal Spitz on 10/24/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFormBaseCell : UITableViewCell

@property (nonatomic, readonly) BOOL isEmpty;
@property (nonatomic, readonly) id value;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)setup;
- (void)setConstraints;

- (void)showRequiredFlag:(BOOL)show;
- (BOOL)isRequiredFlagVisible;

+ (instancetype)cellFromDictionary:(NSDictionary *)dictionary;
- (void)setFromDictionary:(NSDictionary *)srcDictionary;

@end
