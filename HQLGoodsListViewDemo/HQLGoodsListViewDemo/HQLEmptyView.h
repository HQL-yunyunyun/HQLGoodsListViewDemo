//
//  HQLEmptyView.h
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/7.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQLEmptyView : UIView

@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) void(^tapBlock)();

@end
