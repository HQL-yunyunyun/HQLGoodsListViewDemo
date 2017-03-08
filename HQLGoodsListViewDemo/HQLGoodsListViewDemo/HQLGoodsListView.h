//
//  HQLGoodsListView.h
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/6.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMGoodsListCell.h"

@class HMCategoriesModel, HQLGoodsListView;

@protocol HQLGoodsListViewDelegate <NSObject>

@required
// 刷新的代理

@optional

/**
 点击了添加商品的按钮

 @param listView listView
 @param tableView 显示goods的tableView
 @param button "添加"按钮
 @param buttonType 按钮的类型 --- 加 / 减 / 选择规格
 @param indexPath indexPath.section 是category的index indexPath.row 是goods的index
 */
- (void)goodsListView:(HQLGoodsListView *)listView tableView:(UITableView *)tableView listCellDidClickButton:(UIButton *)button buttonType:(buttonType)buttonType indexPath:(NSIndexPath *)indexPath;

/**
 点击了在edit模式下 点击了checkButton

 @param listView listView
 @param tableView 显示goods的tableView
 @param checkButton checkButton
 @param indexPath indexPath.section 是category的index indexPath.row 是goods的index
 */
- (void)goodsListView:(HQLGoodsListView *)listView tableView:(UITableView *)tableView listCellDidClickCheckButton:(UIButton *)checkButton indexPath:(NSIndexPath *)indexPath;

/**
 点击了商品cell

 @param listView listView
 @param tableView 显示goods的tableView
 @param indexPath indexPath.section 是category的index indexPath.row 是goods的index
 */
- (void)goodsListView:(HQLGoodsListView *)listView tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HQLGoodsListView : UIView

@property (strong, nonatomic) NSMutableArray <HMCategoriesModel *>*dataSource;

@property (assign, nonatomic) id <HQLGoodsListViewDelegate>delegate;

/**
 编辑模式

 @param isEdit 是否编辑
 */
- (void)setEdit:(BOOL)isEdit;

- (void)reloadData;

@end
