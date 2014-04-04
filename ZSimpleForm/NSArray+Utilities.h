//
//  NSArray+Utilities.h
//  SitterApp
//
//  Created by Ayal Spitz on 5/25/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Utilities)

- (BOOL)isNotEmpty;

- (id)firstObject;

- (NSArray *)subarrayFromIndex:(NSUInteger)index;
- (NSArray *)subarrayToIndex:(NSUInteger)index;

- (NSArray *)arrayByEnumeratingUsingBlock:(id (^)(id obj, NSUInteger idx, BOOL *stop))block;
- (NSArray *)filterByEnumeratingUsingBlock:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))block;

- (NSMutableDictionary *)dictionaryByEnumeratingUsingBlock:(NSArray *(^)(id obj, NSUInteger idx, BOOL *stop))block;

- (NSArray *)reverse;

// ruby methods
- (id)first;
- (id)last;

- (void)each:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;
- (NSArray *)map:(id (^)(id obj, NSUInteger idx, BOOL *stop))block;

@end
