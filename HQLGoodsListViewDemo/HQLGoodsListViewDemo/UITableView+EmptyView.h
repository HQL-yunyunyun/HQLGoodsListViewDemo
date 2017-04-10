//
//  UITableView+EmptyView.h
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/7.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQLEmptyView.h"

@class HQLEmptyView;

@interface UITableView (EmptyView)

@property (strong, nonatomic) UIImage *emptyViewImage;
@property (copy, nonatomic) NSString *emptyViewTitle;
@property (copy, nonatomic) void(^emptyTapBlock)();

@property (strong, nonatomic) HQLEmptyView *emptyView;

/**
 是否启用emptyView --- 如果为NO 则不启用 , 如果为YES 则符合条件下启用
 */
@property (assign, nonatomic) BOOL isUseEmptyView;

@end
