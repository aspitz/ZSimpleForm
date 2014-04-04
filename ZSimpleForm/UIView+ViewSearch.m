//
//  UIView+ViewSearch.m
//
//  Created by Ayal Spitz on 7/22/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "UIView+ViewSearch.h"

@implementation UIView (ViewSearch)

- (id)superviewOfKind:(Class)aClass{
    UIView *view = [self superview];
    while (view != nil && ![view isKindOfClass:aClass]) {
        view = [view superview];
    }
    
    return view;
}

- (NSArray *)subviewsOfKind:(Class)aClass{
    return [self subviewsOfKind:aClass stopOnFirstMatch:NO];
}

- (id)firstSubviewOfKind:(Class)aClass{
    return [[self subviewsOfKind:aClass stopOnFirstMatch:YES] lastObject];
}

- (NSArray *)subviewsOfKind:(Class)aClass stopOnFirstMatch:(BOOL)stopOnFirstMatch{
    NSMutableArray *matches = [NSMutableArray array];
    NSMutableArray *subviews = [NSMutableArray arrayWithArray:[self subviews]];
    
    while ([subviews count] > 0) {
        UIView *subview = subviews[0];
        [subviews removeObjectAtIndex:0];
        
        if ([subview isKindOfClass:aClass]) {
            [matches addObject:subview];
            if (stopOnFirstMatch) {
                break;
            }
        }
        else {
            [subviews addObjectsFromArray:[subview subviews]];
        }
    }
    
    return matches;
}

- (UIView *)ancestor:(NSUInteger)generation{
    UIView *ancestor = self;
    
    for (NSUInteger i=0;i<generation;i++){
        ancestor = [ancestor superview];
    }
    
    return ancestor;
}

@end
