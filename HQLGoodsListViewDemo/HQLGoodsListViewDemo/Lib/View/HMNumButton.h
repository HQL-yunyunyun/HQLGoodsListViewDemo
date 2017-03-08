//
//  HMNumButton.h
//  HuanMoney
//
//  Created by weplus on 16/9/6.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    buttonTypeAdd = 0, // 加
    buttonTypeSubtract, // 减
    buttonTypeChooseSku // 选择规格
} buttonType;

typedef enum {
    numButtonStyleAddSub, // 加减的样式
    numButtonStyleChoose, // 选择的样式
    numButtonStyleNormal   // 加减的样式下,不做动画,并当count=1的时候,减按钮不能点击
} numButtonStyle;

@class HMNumButton;

@protocol HMNumButtonDelegate <NSObject>

- (void)numButton:(HMNumButton *)button buttonDidClick:(UIButton *)btn buttonType:(buttonType)buttonType;

@end

@interface HMNumButton : UIView

/**
 *  是否已经展开
 */
@property (assign, nonatomic) BOOL isExpand;

/**
 *  想要改变button中的num,要手动改变count值,内部不做处理
 */
@property (assign, nonatomic) NSInteger count;

@property (assign, nonatomic) CGRect addButtonFrame;

@property (weak, nonatomic) UIButton *addButton;

@property (weak, nonatomic) UIButton *subButton;

@property (weak, nonatomic) UIButton *chooseButton;

@property (assign, nonatomic) id <HMNumButtonDelegate>delegate;

/**
 设置最大的数量,当当前count = maxCountNum ,则加按钮不能点击 // 默认为0,不做限制
 */
@property (assign, nonatomic) NSInteger maxCountNum;

/**
 在初始状态下,是否可用
 */
@property (assign, nonatomic) BOOL buttonEnable;

- (instancetype)initWithFrame:(CGRect)frame buttonStyle:(numButtonStyle)style;

- (void)numButtonHideButton:(BOOL)animated;

- (void)numButtonShowButton:(BOOL)animated;

@end
