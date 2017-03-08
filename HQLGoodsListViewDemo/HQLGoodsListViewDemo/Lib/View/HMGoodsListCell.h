//
//  HMGoodsListCell.h
//  HuanMoney
//
//  Created by weplus on 16/9/2.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMNumButton.h"

@class HMGoodsModel;
@class HMGoodsListCell;

typedef enum {
    HQLGoodsListCellSoldMode ,
    HQLGoodsListCellManageMode
} HQLGoodsListCellMode;

@protocol HMGoodsListCellDelegate <NSObject>

@required
- (void)goodsListCell:(HMGoodsListCell *)cell didClickButton:(UIButton *)btn buttonType:(buttonType)buttonType;

@end

@interface HMGoodsListCell : UITableViewCell

@property (strong, nonatomic) HMGoodsModel *model;

@property (assign, nonatomic) id <HMGoodsListCellDelegate>delegate;

@property (assign, nonatomic) CGRect addButtonFrame;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) HQLGoodsListCellMode cellMode;

- (void)setEdit:(BOOL)isEdit;

- (void)setButtonCount:(NSInteger)count;

- (void)goodsListCellHideButton:(BOOL)animated;

- (void)goodsListCellShowButton:(BOOL)animated;

@end
