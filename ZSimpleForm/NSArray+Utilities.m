//
//  NSArray+Utilities.m
//
//  Created by Ayal Spitz on 5/25/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "NSArray+Utilities.h"

@implementation NSArray (Utilities)

#pragma mark - empty

- (BOOL)isNotEmpty{
    return (self.count != 0);
}

#pragma mark - access methods

- (id)firstObject{
    id obj = nil;
    
    if ([self isNotEmpty]){
        obj = self[0];
    }
    
    return obj;
}

#pragma mark - subarray methods

// subarray from index - including index
- (NSArray *)subarrayFromIndex:(NSUInteger)index{
    return [self subarrayWithRange:NSMakeRange(index,self.count - index)];
}

// subarray to index - does not include index
- (NSArray *)subarrayToIndex:(NSUInteger)index{
    return [self subarrayWithRange:NSMakeRange(0, index)];
}

#pragma mark - map method

- (NSArray *)arrayByEnumeratingUsingBlock:(id (^)(id obj, NSUInteger idx, BOOL *stop))block{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id result = block(obj, idx, stop);
        if (result != nil){
            [array addObject:result];
        }
    }];
    
    return array;
}

- (NSArray *)filterByEnumeratingUsingBlock:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))block{
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj, idx, stop)){
            [mutableArray addObject:obj];
        }
    }];
    
    return mutableArray;
}

- (NSMutableDictionary *)dictionaryByEnumeratingUsingBlock:(NSArray *(^)(id obj, NSUInteger idx, BOOL *stop))block{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *keyValue = block(obj, idx, stop);
        dictionary[keyValue[0]] = keyValue[1];
    }];
    
    return dictionary;
}

#pragma mark - ruby methods

- (id)first{
    return self.firstObject;
}

- (id)last{
    return self.lastObject;
}

- (void)each:(void (^)(id obj, NSUInteger idx, BOOL *stop))block{
    [self enumerateObjectsUsingBlock:block];
}

- (NSArray *)map:(id (^)(id obj, NSUInteger idx, BOOL *stop))block{
    return [self arrayByEnumeratingUsingBlock:block];
}

- (NSArray *)reverse{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in [self reverseObjectEnumerator]){
        [array addObject:obj];
    }
    return array;
}

@end
