//
//  HQLNumberButton.m
//  numberButtonDemo
//
//  Created by weplus on 16/8/31.
//  Copyright © 2016年 weplus. All rights reserved.
//

#import "HQLNumberButton.h"

#define imageWidth 18.33
#define imageHeight 18.53
#define selfWidth 22
#define selfHeight 21

@interface HQLNumberButton ()

@property (strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation HQLNumberButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    HQLNumberButton *button = [[HQLNumberButton alloc] init];
    return button;
}

- (instancetype)init {
    if (self = [super init]) {
        [self prepqreUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepqreUI];
    }
    return self;
}

- (instancetype)initWithButtonPattern:(HQLNumberButtonPattern)pattern {
    if (self = [self init]) {
        self.buttonPattern = pattern;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self prepqreUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 计算frame
    // 水平偏移量
    CGFloat imageOffsetHori = ((selfWidth - imageWidth) / selfWidth) * self.frame.size.width;
    // 垂直偏移量
    CGFloat imageOffsetVert = ((selfHeight - imageHeight) / selfHeight) * self.frame.size.height;
    CGFloat imageViewW = self.frame.size.width - imageOffsetHori;
    CGFloat imageViewH = self.frame.size.height - imageOffsetVert;
    self.imageView.frame = CGRectMake(0, 0, imageViewW, imageViewH);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(imageViewW * 0.5, imageViewH * 0.5);
    
    self.backgroundImageView.frame = CGRectMake(imageOffsetHori, imageOffsetVert, imageViewW, imageViewH);
}

- (void)prepqreUI {
    self.buttonPattern = HQLNumberButtonPatternButton;
    self.backgroundColor = [UIColor clearColor];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self setNum:0];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self bringSubviewToFront:self.titleLabel];
}

- (void)animationStart {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.titleLabel.transform = CGAffineTransformMakeScale(3.0, 3.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.titleLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

#pragma mark - getter && setter

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"items_bg_down"]];
        [self addSubview:_backgroundImageView];
        [self bringSubviewToFront:self.imageView];
    }
    return _backgroundImageView;
}

- (void)setButtonPattern:(HQLNumberButtonPattern)buttonPattern {
    _buttonPattern = buttonPattern;
    if (buttonPattern == HQLNumberButtonPatternButton) {
        [self setImage:[UIImage imageNamed:@"items_bg_up"] forState:UIControlStateNormal];
        [self.backgroundImageView setImage:[UIImage imageNamed:@"items_bg_down"]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if (buttonPattern == HQLNumberButtonPatternView) {
        [self setImage:[UIImage imageNamed:@"item-bg_up_view"] forState:UIControlStateNormal];
        [self.backgroundImageView setImage:[UIImage imageNamed:@"item-bg_down_view"]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)setNum:(NSInteger)num {
    _num = num;
    [self setTitle:[NSString stringWithFormat:@"%ld",(long)num] forState:UIControlStateNormal];
}

@end
