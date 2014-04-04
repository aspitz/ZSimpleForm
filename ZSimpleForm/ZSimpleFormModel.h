//
//  ZSimpleFormModel.h
//
//  Created by Ayal Spitz on 11/22/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFormFieldModel.h"

@interface ZSimpleFormModel : NSObject

@property (nonatomic, strong) NSMutableArray *fields;
@property (nonatomic, readonly) NSUInteger count;

+ (instancetype)model;
+ (instancetype)modelWithFields:(NSArray *)fields;

- (ZFormFieldModel *)addField:(ZFormFieldModel *)field;

- (ZFormFieldModel *)addFieldOfType:(NSString *)fieldType;
- (ZFormFieldModel *)addFieldOfType:(NSString *)fieldType withValue:(id)value;

- (ZFormFieldModel *)addFieldOfType:(ZFormFieldType)fieldType titled:(NSString *)title;
- (ZFormFieldModel *)addFieldOfType:(ZFormFieldType)fieldType titled:(NSString *)title withValue:(id)value;
- (ZFormFieldModel *)addFieldOfType:(ZFormFieldType)fieldType titled:(NSString *)title withAttributes:(NSDictionary *)attributes;
- (ZFormFieldModel *)addFieldOfType:(ZFormFieldType)fieldType titled:(NSString *)title withValue:(id)value andAttributes:(NSDictionary *)attributes;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)enumerateFieldModelsUsingBlock:(void (^)(ZFormFieldModel *fieldModel, NSUInteger idx, BOOL *stop))block;

- (void)clear;
- (NSArray *)invalidFields;

@end
