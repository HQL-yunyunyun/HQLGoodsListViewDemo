//
//  HQLGoodsListView.h
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/6.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQLGoodsListView : UIView

@property (strong, nonatomic) NSMutableArray *dataSource;

- (void)reloadData;

@end
