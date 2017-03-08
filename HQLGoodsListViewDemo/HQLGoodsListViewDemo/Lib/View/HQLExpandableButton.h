//
//  HQLExpandableButton.h
//  HQLExpandableButtonDemo
//
//  Created by 何启亮 on 16/9/2.
//  Copyright © 2016年 HQL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick)(UIButton *);

typedef enum{
    scrollDirectionUP = 0, // 上
    scrollDirectionRight,
    scrollDirectionDown,
    scrollDirectionleft
} scrollDirection;

@class HQlExpandableButtonAction;

@interface HQLExpandableButton : UIView

/**
 *  子button
 */
@property (strong, nonatomic, readonly) NSArray <UIButton *>*subButtons;

@property (assign, nonatomic) scrollDirection diretion;

@property (assign, nonatomic) CGFloat duringTime;

/**
 *  是否在展开之后，第一次点击遍收回button
 */
@property (assign, nonatomic) BOOL isHideWhenClickInFistTimes;

// frame 是button的初始frame
- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(scrollDirection)direction;

- (void)addAction:(HQlExpandableButtonAction *)action;

// 设置button的frame是没用的
- (void)addButton:(UIButton *)button buttonClick:(buttonClick)buttonClick;

- (void)showAnimate:(BOOL)animated animate:(void(^)())animate completion:(void(^)())completion;

- (void)hideAnimate:(BOOL)animated animate:(void(^)())animate completion:(void(^)())completion;

@end


@interface HQlExpandableButtonAction : NSObject

@property (copy, nonatomic) NSString *buttonTitle;

@property (strong, nonatomic) UIImage *buttonImage;

@property (copy, nonatomic) buttonClick buttonClick;

@property (strong, nonatomic) UIColor *titleColor;

@property (assign, nonatomic) CGFloat fontSize;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image buttonClick:(buttonClick)buttonClick titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize;

@end