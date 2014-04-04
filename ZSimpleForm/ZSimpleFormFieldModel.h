//
//  ZSimpleFormFieldModel.h
//
//  Created by Ayal Spitz on 2/24/14.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "ZFormFieldModel.h"

@interface ZSimpleFormFieldModel : ZFormFieldModel

- (instancetype)initWithTitle:(NSString *)title;

+ (instancetype)fieldOfType:(ZFormFieldType)type;

@end
