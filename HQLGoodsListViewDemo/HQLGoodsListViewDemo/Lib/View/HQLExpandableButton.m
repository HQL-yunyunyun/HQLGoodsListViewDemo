//
//  HQLExpandableButton.m
//  HQLExpandableButtonDemo
//
//  Created by 何启亮 on 16/9/2.
//  Copyright © 2016年 HQL. All rights reserved.
//

#import "HQLExpandableButton.h"

#define kButtonTagConst 8820

@interface HQLExpandableButton ()

@property (nonatomic, strong) NSMutableArray <UIButton *>*buttonArray;

@property (nonatomic, strong) NSMutableArray <buttonClick>*buttonClickArray;

@property (nonatomic, assign) CGRect originFrame;

@property (assign, nonatomic) BOOL isExpand;

@property (assign, nonatomic) CGRect defalutFrame;

@end

@implementation HQLExpandableButton

- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(scrollDirection)direction {
    if (self = [super initWithFrame:frame]) {
        self.originFrame = frame;
        self.diretion = direction;
        self.duringTime = 0.3;
        self.defalutFrame = frame;
    }
    return self;
}

#pragma mark - event

- (void)addAction:(HQlExpandableButtonAction *)action {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.defalutFrame.size.width, self.defalutFrame.size.height)];
    [button setTitle:action.buttonTitle forState:UIControlStateNormal];
    [button setImage:action.buttonImage forState:UIControlStateNormal];
    [button setTitleColor:action.titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:action.fontSize]];
    [self addButton:button buttonClick:action.buttonClick];
}

- (void)addButton:(UIButton *)button buttonClick:(buttonClick)buttonClick {
    [self.buttonArray addObject:button];
    [self addSubview:button];
    [button setTag:(kButtonTagConst + self.buttonArray.count - 1)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.alpha = self.buttonArray.count == 1 ? 1 : 0;
    _subButtons = self.buttonArray.copy;
    if (!buttonClick) {
        buttonClick = ^(UIButton *btn) {};
    }
    [self.buttonClickArray addObject:buttonClick];
}

- (void)buttonClick:(UIButton *)btn {
    if (_isHideWhenClickInFistTimes) {
        __weak typeof(self) weakSelf = self;
        if (_isExpand) {
            [self hideAnimate:YES animate:^{
                [weakSelf hideButton:btn];
            } completion:^{
                
            }];
        } else {
            [self showAnimate:YES animate:^{
                
            } completion:^{
                
            }];
        }
    }
    NSInteger tag = btn.tag;
    buttonClick buttonClick = self.buttonClickArray[tag - kButtonTagConst];
    buttonClick(btn);
}

- (void)showAnimate:(BOOL)animated animate:(void(^)())animate completion:(void(^)())completion {
    if (_isExpand) return;
    self.isExpand = YES; // 只要是进来了这个方法,就默认已经展开了
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animated ? weakSelf.duringTime : 0 animations:^{
        weakSelf.frame = [weakSelf getAnimateFrame];
        for (UIButton *button in weakSelf.buttonArray) {
            button.alpha = 1;
        }
        if (animate) {
            animate();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)hideAnimate:(BOOL)animated animate:(void(^)())animate completion:(void(^)())completion {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animated ? weakSelf.duringTime : 0 animations:^{
        weakSelf.frame = weakSelf.originFrame;
        if (!weakSelf.isHideWhenClickInFistTimes) {
            [weakSelf hideButton:weakSelf.buttonArray.firstObject];
        }
        if (animate) {
            animate();
        }
    } completion:^(BOOL finished) {
        weakSelf.isExpand = NO; // 关闭只有在完全关闭的时候才能赋值
        if (completion) {
            completion();
        }
    }];
}

- (void)hideButton:(UIButton *)btn {
    CGRect btnF = btn.frame;
    btnF.origin = CGPointZero;
    btn.frame = btnF;
    for (UIButton *button in self.buttonArray) {
        if (button == btn) continue;
        button.alpha = 0;
    }
}

#pragma mark - private method

- (CGRect)getAnimateFrame {
    CGRect targetFrame = CGRectZero;
    CGFloat defaultWidth = self.defalutFrame.size.width;
    CGFloat defaultHeight = self.defalutFrame.size.height;
    CGFloat defaultX = self.defalutFrame.origin.x;
    CGFloat defaultY = self.defalutFrame.origin.y;
    CGFloat targetWidht = defaultWidth * self.buttonArray.count;
    CGFloat targetHeight = defaultHeight * self.buttonArray.count;
    switch (self.diretion) {
        case scrollDirectionUP:
            targetFrame = CGRectMake(defaultX, defaultY - targetHeight + defaultHeight, defaultWidth, targetHeight);
            for (NSInteger i = self.buttonArray.count - 1; i >= 0 ; i--) {
                UIButton *button = self.buttonArray[i];
                UIButton *preButton = nil;
                if (i != self.buttonArray.count - 1) {
                    preButton = self.buttonArray[i + 1];
                }
                CGFloat buttonY = CGRectGetMaxY(preButton.frame);
                
                CGRect buttonF = button.frame;
                buttonF.origin.y = buttonY;
                button.frame = buttonF;
            }
            break;
        case scrollDirectionRight:
            targetFrame = CGRectMake(defaultX, defaultY, targetWidht, defaultHeight);
            for (NSInteger i = 0; i < self.buttonArray.count; i++) {
                UIButton *button = self.buttonArray[i];
                UIButton *preButton = nil;
                if (i != 0) {
                    preButton = self.buttonArray[i - 1];
                }
                CGFloat buttonX = CGRectGetMaxX(preButton.frame);
                
                CGRect buttonF = button.frame;
                buttonF.origin.x = buttonX;
                button.frame = buttonF;
            }
            break;
        case scrollDirectionDown:
            targetFrame = CGRectMake(defaultX, defaultY, defaultWidth, targetHeight);
            for (NSInteger i = 0; i < self.buttonArray.count; i++) {
                UIButton *button = self.buttonArray[i];
                UIButton *preButton = nil;
                if (i != 0) {
                    preButton = self.buttonArray[i - 1];
                }
                CGFloat buttonY = CGRectGetMaxY(preButton.frame);
                CGRect buttonF = button.frame;
                buttonF.origin.y = buttonY;
                button.frame = buttonF;
            }
            break;
        case scrollDirectionleft:
            targetFrame = CGRectMake(defaultX - targetWidht + defaultWidth, defaultY, targetWidht, defaultHeight);
            for (NSInteger i = self.buttonArray.count - 1; i >= 0 ; i--) {
                UIButton *button = self.buttonArray[i];
                UIButton *preButton = nil;
                if (i != self.buttonArray.count - 1) {
                    preButton = self.buttonArray[i + 1];
                }
                CGFloat buttonX = CGRectGetMaxX(preButton.frame);
                
                CGRect buttonF = button.frame;
                buttonF.origin.x = buttonX;
                button.frame = buttonF;
            }
            break;
        default:
            targetFrame = CGRectZero;
            break;
    }
    return targetFrame;
}

#pragma mark - getter && setter

- (NSMutableArray<UIButton *> *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray <buttonClick> *)buttonClickArray {
    if (!_buttonClickArray) {
        _buttonClickArray = [NSMutableArray array];
    }
    return _buttonClickArray;
}

@end


@implementation HQlExpandableButtonAction

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image buttonClick:(buttonClick)buttonClick titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize {
    if (self = [super init]) {
        self.buttonTitle = title;
        self.buttonImage = image;
        self.buttonClick = buttonClick;
        self.titleColor = titleColor;
        self.fontSize = fontSize;
    }
    return self;
}

@end