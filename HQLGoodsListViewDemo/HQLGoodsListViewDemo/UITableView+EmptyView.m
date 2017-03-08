//
//  UITableView+EmptyView.m
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/7.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "UITableView+EmptyView.h"
#import <objc/runtime.h>

@implementation UITableView (EmptyView)

+ (void)load {
    [super load];
    Method fromMethod = class_getInstanceMethod([self class], @selector(reloadData));
    Method toMethod = class_getInstanceMethod([self class], @selector(HQL_reloadData));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (void)HQL_reloadData {
    
    [self HQL_reloadData];
    
    NSLog(@"sections : %ld", self.numberOfSections);
    for (int i = 0; i < self.numberOfSections; i++) {
        NSLog(@"row : %ld", [self numberOfRowsInSection:i]);
    }
}

@end
