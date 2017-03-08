//
//  HMGoodsListCell.m
//  HuanMoney
//
//  Created by weplus on 16/9/2.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import "HMGoodsListCell.h"
#import "HMGoodsModel.h"
#import "HMSkuModel.h"

#define ZXWeakSelf typeof(self) weakSelf = self

//#import <SDWebImage/UIImageView+WebCache.h>

@interface HMGoodsListCell () <HMNumButtonDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *soldoutView;

@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@property (weak, nonatomic) IBOutlet UIButton *checkButton;

// 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewLeadingConstraint;

// 选择规格
@property (strong, nonatomic) HMNumButton *chooseButton;

// 加减
@property (strong, nonatomic) HMNumButton *addSubButton;

@end

@implementation HMGoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupData:self.model];
}

- (void)setModel:(HMGoodsModel *)model {
    _model = model;
    [self setupData:model];
}

- (void)setupData:(HMGoodsModel *)model {
    [self layoutIfNeeded];
    // 图片
    NSString *path = nil;
    if (model.galleries && model.galleries.count != 0) {
        path = (NSString *)model.galleries.firstObject[@"thumbnail"];
    } else {
        for (HMSkuModel *sku in model.skus) {
            if (sku.galleries && sku.galleries.count != 0) {
                path = (NSString *)sku.galleries.firstObject[@"thumbnail"];
                break;
            }
        }
    }
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"goodsCell_placehodlerImage"]];
    // 名字
    self.titleLabel.text = model.title;
    
    // 价格
    NSString *price = model.price_range.count == 2 ? [NSString stringWithFormat:@"￥%.2f~%.2f",[model.price_range.firstObject doubleValue] / 100.0,[model.price_range.lastObject doubleValue] / 100.0] : [NSString stringWithFormat:@"￥%.2f",[model.price_range.firstObject doubleValue] / 100.0];
    self.priceLabel.text = price;
    // button
    self.addSubButton.hidden = model.sku_properties.count;
    self.chooseButton.hidden = !self.addSubButton.hidden;
    [self setButtonCount:model.selectedCount];
    self.addButtonFrame = self.addSubButton.addButtonFrame;
    
    if (self.cellMode == HQLGoodsListCellSoldMode) {
        self.soldoutView.hidden = model.stock_count != 0;
    }
    self.chooseButton.buttonEnable = model.stock_count != 0;
    self.addSubButton.buttonEnable = model.stock_count != 0;
    
    [self.stockLabel setText:[NSString stringWithFormat:@"库存:%@", model.stock_count]];
    
    [self animateWithIsEdit:model.HQL_isEdit animate:NO];
    
    self.height = 100;
}

- (void)goodsListCellHideButton:(BOOL)animated {
    [self.addSubButton numButtonHideButton:animated];
}

- (void)goodsListCellShowButton:(BOOL)animated {
    [self.addSubButton numButtonShowButton:animated];
}

- (void)setButtonCount:(NSInteger)count {
    [self.addSubButton setCount:count];
    [self.chooseButton setCount:count];
}

- (void)setEdit:(BOOL)isEdit {
    [self animateWithIsEdit:isEdit animate:YES];
}

- (void)animateWithIsEdit:(BOOL)isEdit animate:(BOOL)animated {
    CGFloat duration = animated ? 0.3 : 0;
    ZXWeakSelf;
    if (isEdit) {
        // 为编辑状态
        [UIView animateWithDuration:duration animations:^{
            weakSelf.iconViewLeadingConstraint.constant = 10 + 10 + 18;
            [weakSelf layoutIfNeeded];
            [weakSelf.checkButton setAlpha:1];
        }];
    } else {
        // 非编辑状态
        [UIView animateWithDuration:duration animations:^{
            weakSelf.iconViewLeadingConstraint.constant = 10;
            [weakSelf layoutIfNeeded];
            [weakSelf.checkButton setAlpha:0];
        }];
    }
}
- (IBAction)checkButtonDidClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.model.HQL_isSelected = sender.isSelected;
}

#pragma mark - num button delegate

- (void)numButton:(HMNumButton *)button buttonDidClick:(UIButton *)btn buttonType:(buttonType)buttonType {
    if (!self.delegate) return;
    switch (buttonType) {
        case buttonTypeAdd: {
            break;
        }
        case buttonTypeSubtract: {
            break;
        }
        case buttonTypeChooseSku: {
        
        }
        default:
            break;
    }
    [self.delegate goodsListCell:self didClickButton:btn buttonType:buttonType];
//     button.count = self.model.selectedCount;  // 数据的更新由控制器来完成
}

#pragma mark - getter && setter

- (void)setCellMode:(HQLGoodsListCellMode)cellMode {
    if (cellMode == HQLGoodsListCellSoldMode) {
        [self.buttonView setHidden:NO];
        [self.stockLabel setHidden:YES];
    } else if (cellMode == HQLGoodsListCellManageMode) {
        [self.buttonView setHidden:YES];
        [self.stockLabel setHidden:NO];
        [self.soldoutView setHidden:YES];
    }
}

- (HMNumButton *)chooseButton {
    if (!_chooseButton) {
        _chooseButton = [[HMNumButton alloc] initWithFrame:self.buttonView.bounds buttonStyle:numButtonStyleChoose];
        _chooseButton.delegate = self;
        _chooseButton.hidden = YES;
        [self.buttonView addSubview:_chooseButton];
    }
    return _chooseButton;
}

- (HMNumButton *)addSubButton {
    if (!_addSubButton) {
        _addSubButton = [[HMNumButton alloc] initWithFrame:self.buttonView.bounds buttonStyle:numButtonStyleAddSub];
        _addSubButton.delegate = self;
        _addSubButton.hidden = YES;
        [self.buttonView addSubview:_addSubButton];
    }
    return _addSubButton;
}

@end
