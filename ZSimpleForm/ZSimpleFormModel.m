//
//  ZSimpleFormModel.m
//
//  Created by Ayal Spitz on 11/22/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZSimpleFormModel.h"
#import "ZFormFieldModel.h"
#import "ZSimpleFormFieldModel.h"

@implementation ZSimpleFormModel

#pragma mark - Init methods

- (instancetype)init{
    self = [super init];
    if (self) {
        self.fields = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)model{
    return [[[self class]alloc]init];
}

+ (instancetype)modelWithFields:(NSArray *)fields{
    ZSimpleFormModel *model = [self model];
    
    [fields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if ([obj isKindOfClass:[NSArray class]]){
            NSArray *simpleTextElement = obj;
            [model addField:[ZFormFieldModel fieldWithTitle:simpleTextElement[1]]].validationBlock = [ZFormFieldModel emptyValidationBlock];
        } else {
            NSString *fieldType = obj;
            ZSimpleFormFieldModel *formFieldModel = [ZSimpleFormFieldModel fieldOfType:fieldType];
            formFieldModel.validationBlock = [ZFormFieldModel emptyValidationBlock];
            [model addField:formFieldModel];
        }
    }];

    return model;
}

#pragma mark - ZOrderedDictionary methods
- (NSUInteger)count{
    return self.fields.count;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx{
    return self.fields[idx];
}

- (void)enumerateFieldModelsUsingBlock:(void (^)(ZFormFieldModel *fieldModel, NSUInteger idx, BOOL *stop))block{
    [self.fields enumerateObjectsUsingBlock:block];
}

#pragma mark - Add field methods

- (ZFormFieldModel *)addField:(ZFormFieldModel *)field{
    [self.fields addObject:field];
    return field;
}

- (ZFormFieldModel *)addFieldOfType:(NSString *)fieldType{
    return [self addFieldOfType:fieldType withValue:nil];
}

- (ZFormFieldModel *)addFieldOfType:(NSString *)fieldType withValue:(id)value{
    ZFormFieldModel *field = [ZFormFieldModel fieldOfType:fieldType];

    field.value = value;
    [self addField:field];
    
    return field;
}

#pragma mark - Add field methods

- (ZFormFieldModel *)addFieldOfType:(ZFormFieldType)fieldType titled:(NSString *)title{
    return [self addFieldOfType:fieldType titled:title withValue:nil andAttributes:nil];
}

- (ZFormFieldModel *)addFieldOfType:(ZFormFieldType)fieldType titled:(NSString *)title withValue:(id)value{
    return [self addFieldOfType:fieldType titled:title withValue:value andAttributes:nil];
}

- (ZFormFieldModel *)addFieldOfType:(ZFormFieldType)fieldType titled:(NSString *)title withAttributes:(NSDictionary *)attributes{
    return [self addFieldOfType:fieldType titled:title withValue:nil andAttributes:attributes];
}

- (ZFormFieldModel *)addFieldOfType:(ZFormFieldType)fieldType titled:(NSString *)title withValue:(id)value andAttributes:(NSDictionary *)attributes{
    ZFormFieldModel *field = [ZFormFieldModel fieldWithTitle:title];
    field.fieldType = fieldType;
    field.value = value;
    [field.attributes addEntriesFromDictionary:attributes];
    
    [self addField:field];
    
    return field;
}

#pragma mark - 

- (void)clear{
    [self.fields enumerateObjectsUsingBlock:^(ZFormFieldModel *formFieldModel, NSUInteger idx, BOOL *stop) {
        [formFieldModel clearValue];
    }];
}
     
- (NSArray *)invalidFields{
    NSMutableArray *invalidFields = [NSMutableArray array];
    
    [self.fields enumerateObjectsUsingBlock:^(ZFormFieldModel *formFieldModel, NSUInteger idx, BOOL *stop) {
        [formFieldModel validate];
        if (!formFieldModel.isValid){
            [invalidFields addObject:formFieldModel];
        }
    }];
    
    return invalidFields;
}

@end
