//
//  HMNumButton.m
//  HuanMoney
//
//  Created by weplus on 16/9/6.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import "HMNumButton.h"
#import "HQLExpandableButton.h"

#define ZXWeakSelf typeof(self) weakSelf = self
#define ZXColor( r, g, b) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1]

@interface HMNumButton ()

@property (weak, nonatomic) UIButton *numButton;

@property (weak, nonatomic) HQLExpandableButton *buttonView;

@property (assign, nonatomic) numButtonStyle style;

@end

@implementation HMNumButton

- (instancetype)initWithFrame:(CGRect)frame buttonStyle:(numButtonStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.maxCountNum = 0;
        if (style == numButtonStyleAddSub) {
            [self prepareAddSubUI];
        } else if (style == numButtonStyleChoose) {
            [self prepareChooseUI];
        } else if (style == numButtonStyleNormal) {
            [self prepareAddSubUI];
        }
    }
    return self;
}

- (void)numButtonHideButton:(BOOL)animated {
    [self.buttonView hideAnimate:animated animate:nil completion:nil];
}

- (void)numButtonShowButton:(BOOL)animated {
    [self.buttonView showAnimate:animated animate:nil completion:nil];
}

- (void)setCount:(NSInteger)count {
    _count = count;
    // 每次点击完之后都更新num
    [self.numButton setTitle:[NSString stringWithFormat:@"%ld",(long)self.count] forState:UIControlStateNormal];
    // 如果count == 0,则hide
    ZXWeakSelf;
    // 设置加按钮是否可用
    if (count >=self.maxCountNum && self.maxCountNum != 0) {
        self.addButton.enabled = NO;
    } else {
        self.addButton.enabled = YES;
    }
    if (self.style == numButtonStyleNormal) {
        if (count <= 1) {
            self.subButton.enabled = NO;
        } else {
            self.subButton.enabled = YES;
        }
        [self.buttonView showAnimate:NO animate:^{
            weakSelf.isExpand = YES;
        } completion:^{
            
        }];
    } else if (self.style == numButtonStyleAddSub) {
        if (count == 0) {
            [self.buttonView hideAnimate:YES animate:^{
                
            } completion:^{
                weakSelf.isExpand = NO;
            }];
        } else {
            if (!self.isExpand) {
                [self.buttonView showAnimate:YES animate:^{
                    weakSelf.isExpand = YES;
                } completion:^{
                    
                }];
            }
        }
    } else if (self.style == numButtonStyleChoose) {
        NSString *title = @"选择规格";
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:title];
        if (count != 0) {
            [attriString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %ld",(long)count] attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}]];
        }
        [self.chooseButton setAttributedTitle:attriString forState:UIControlStateNormal];
    }
}

#pragma mark - prepare UI

// 选择样式
- (void)prepareChooseUI {
    ZXWeakSelf;
    CGFloat buttonX = self.frame.size.width - 74;
    HQLExpandableButton *button = [weakSelf setupButtonView:CGRectMake(buttonX, 0, 74, 30)];
    HQlExpandableButtonAction *action = [[HQlExpandableButtonAction alloc] initWithTitle:@"选择规格" image:nil buttonClick:^(UIButton *btn) {
        if ([weakSelf.delegate respondsToSelector:@selector(numButton:buttonDidClick:buttonType:)]) {
            [weakSelf.delegate numButton:weakSelf buttonDidClick:btn buttonType:buttonTypeChooseSku];
        }
    } titleColor:ZXColor(106, 106, 106) fontSize:12];
    [button addAction:action];
    
    self.chooseButton = button.subviews.firstObject;
    self.buttonView = button;
}

// 加减样式
- (void)prepareAddSubUI {
    ZXWeakSelf;
    CGFloat buttonX = self.frame.size.width - 30;
    HQLExpandableButton *button = [self setupButtonView:CGRectMake(buttonX, 0, 30, 30)];
    // 添加的button
    HQlExpandableButtonAction *addAction = [[HQlExpandableButtonAction alloc] initWithTitle:nil image:[UIImage imageNamed:@"icon-add"] buttonClick:^(UIButton *btn) {
        if ([weakSelf.delegate respondsToSelector:@selector(numButton:buttonDidClick:buttonType:)]) {
            [weakSelf.delegate numButton:weakSelf buttonDidClick:btn buttonType:buttonTypeAdd];
        }
    } titleColor:nil fontSize:12];
    // 显示数字的button
    HQlExpandableButtonAction *numAction = [[HQlExpandableButtonAction alloc] initWithTitle:[NSString stringWithFormat:@"%ld",(long)weakSelf.count] image:nil buttonClick:^(UIButton *btn) {} titleColor:ZXColor(251, 132, 0) fontSize:12];
    // 减去的button
    HQlExpandableButtonAction *subtractAction = [[HQlExpandableButtonAction alloc] initWithTitle:nil image:[UIImage imageNamed:@"icon-subtract"] buttonClick:^(UIButton *btn) {
        if ([weakSelf.delegate respondsToSelector:@selector(numButton:buttonDidClick:buttonType:)]) {
            [weakSelf.delegate numButton:weakSelf buttonDidClick:btn buttonType:buttonTypeSubtract];
        }
    } titleColor:ZXColor(251, 132, 0) fontSize:12];
    
    [button addAction:addAction];
    [button addAction:numAction];
    [button addAction:subtractAction];
    
    self.numButton = button.subButtons[1];
    self.addButton = button.subButtons[0];
    self.subButton = button.subButtons[2];
    self.buttonView = button;
    self.addButtonFrame = button.frame;
}

- (HQLExpandableButton *)setupButtonView:(CGRect)frame {
    HQLExpandableButton *button = [[HQLExpandableButton alloc] initWithFrame:frame scrollDirection:scrollDirectionleft];
    button.isHideWhenClickInFistTimes = NO;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 15;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = ZXColor(230, 230, 230).CGColor;
    button.layer.borderWidth = 1;
    [self addSubview:button];
    return button;
}

- (void)setButtonEnable:(BOOL)buttonEnable {
    _buttonEnable = buttonEnable;
    self.addButton.enabled = buttonEnable;
    self.chooseButton.enabled = buttonEnable;
}

@end
