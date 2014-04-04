//
//  UIView+ViewSearch.h
//
//  Created by Ayal Spitz on 7/22/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewSearch)

- (id)superviewOfKind:(Class)aClass;

- (NSArray *)subviewsOfKind:(Class)aClass;
- (id)firstSubviewOfKind:(Class)aClass;
- (NSArray *)subviewsOfKind:(Class)aClass stopOnFirstMatch:(BOOL)stopOnFirstMatch;

- (UIView *)ancestor:(NSUInteger)generation;

@end
