//
//  UITableView+EmptyView.h
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/7.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQLEmptyView;

@interface UITableView (EmptyView)

@property (assign, nonatomic) BOOL isShowEmptyView;

@property (strong, nonatomic) UIImage *emptyImage;
@property (copy, nonatomic) NSString *emptyTitle;
@property (copy, nonatomic) void(^emptyTapBlock)();
@property (strong, nonatomic) HQLEmptyView *emptyView;

@end
