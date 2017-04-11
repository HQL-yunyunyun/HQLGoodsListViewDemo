//
//  HQLEmptyView.m
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/7.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "HQLEmptyView.h"

@interface HQLEmptyView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation HQLEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    [self titleLabel];
    [self imageView];
    
    // 添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.image) {
        [self setImageViewFrameWithImage:self.image];
    }
    if (self.title) {
        [self setTitleLabelFrame];
    }
}

#pragma mark - event

- (void)tap {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)setTitleLabelFrame {
    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, [self imageViewWidth], self.titleLabel.frame.size.height);
    [self.titleLabel sizeToFit];
    CGFloat titleLabelX = (self.frame.size.width - self.titleLabel.frame.size.width) * 0.5;
//    CGFloat titleLabelY = (self.frame.size.width - self.titleLabel.frame.size.height) * 0.5;
    CGFloat titleLabelY = CGRectGetMaxY(self.imageView.frame) + 5;
    if (titleLabelY <= 5) {
        titleLabelY = (self.frame.size.height - self.titleLabel.frame.size.height) * 0.5;
    }
    
    [self.titleLabel setFrame:CGRectMake(titleLabelX, titleLabelY, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
}

- (void)setImageViewFrameWithImage:(UIImage *)image {
    // 根据Image的比例来设置imageView的宽高
    // 宽度固定
    CGFloat imageViewW = [self imageViewWidth];
    CGFloat imageViewH = (imageViewW * image.size.height) / image.size.width;
    CGFloat imageViewX = (self.frame.size.width - imageViewW) * 0.5;
    CGFloat imageViewY = (self.frame.size.height - imageViewH) * 0.5;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
}

- (CGFloat)imageViewWidth {
    return  self.frame.size.width * 0.7;
}

#pragma mark - setter 

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    [self setImageViewFrameWithImage:image];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_titleLabel setUserInteractionEnabled:YES];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setUserInteractionEnabled:YES];
        [self addSubview:_imageView];
    }
    return _imageView;
}

@end
