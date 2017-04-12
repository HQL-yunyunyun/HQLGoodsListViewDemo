//
//  HQLEmptyView.m
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/7.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "HQLEmptyView.h"

#import <WebKit/WebKit.h>

#define kMargin 10

@interface HQLEmptyView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

//@property (strong, nonatomic) WKWebView *animationWebView; // 显示git的webView

@property (strong, nonatomic) UIWebView *animationWebView;

@property (assign, nonatomic) BOOL isAnimation;

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
    
    UIImageView *imageView = nil;
    if (self.image) {
        [self setImageViewFrameWithImage:self.image];
        imageView = self.imageView;
    }
    
    UILabel *titleLabel = nil;
    if (self.title) {
        [self setTitleLabelFrame];
        titleLabel = self.titleLabel;
    }
    
//    WKWebView *animationWebView = nil;
    if (self.gifData) {
        [self setAnimationWebViewFrame];
    }
    
    // 计算y
    CGFloat totalHeight = CGRectGetHeight(imageView.frame) + CGRectGetHeight(titleLabel.frame) + kMargin;
    CGFloat imageViewY = (self.frame.size.height - totalHeight) * 0.5;
    CGFloat titleLabelY = imageViewY + totalHeight - CGRectGetHeight(titleLabel.frame);
    
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageViewY, imageView.frame.size.width, imageView.frame.size.height);
    titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabelY, titleLabel.frame.size.width, titleLabel.frame.size.height);
}

#pragma mark - event

- (void)tap {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)setAnimationWebViewFrame {
    CGFloat webViewW = [self imageViewWidth];
    CGFloat webViewH = [self imageViewWidth];
    CGFloat webViewX = (self.frame.size.width - webViewW) * 0.5;
    CGFloat webViewY = (self.frame.size.height - webViewH) * 0.5;
    self.animationWebView.frame = CGRectMake(webViewX, webViewY, webViewW, webViewH);
}

- (void)setTitleLabelFrame {
    
    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.frame.size.width - (2 * kMargin), self.titleLabel.frame.size.height);
    [self.titleLabel sizeToFit];
    CGFloat titleLabelX = (self.frame.size.width - self.titleLabel.frame.size.width) * 0.5;
    
    [self.titleLabel setFrame:CGRectMake(titleLabelX, 0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
}

- (void)setImageViewFrameWithImage:(UIImage *)image {
    // 根据Image的比例来设置imageView的宽高
    // 宽度固定
    CGFloat imageViewW = [self imageViewWidth];
    CGFloat imageViewH = (imageViewW * image.size.height) / image.size.width;
    CGFloat imageViewX = (self.frame.size.width - imageViewW) * 0.5;
    self.imageView.frame = CGRectMake(imageViewX, 0, imageViewW, imageViewH);
}

- (CGFloat)imageViewWidth {
    return  self.frame.size.width * 0.6;
}

- (void)startGifAnimaion {
    if (!self.gifData || self.isAnimation) {
        return;
    }
    self.isAnimation = YES;
    [self.animationWebView setHidden:NO];
    self.animationWebView.opaque = YES;
    [self.imageView setHidden:YES];
    [self.titleLabel setHidden:YES];
    
    [self.animationWebView loadData:self.gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
}

- (void)endGifAnimation {
    [self.animationWebView removeFromSuperview];
    self.animationWebView = nil;
    
    self.isAnimation = NO;
    
    [self.imageView setHidden:NO];
    [self.titleLabel setHidden:NO];
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

- (UIWebView *)animationWebView {
    if (!_animationWebView) {
        _animationWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [self imageViewWidth], [self imageViewWidth])];
        _animationWebView.scalesPageToFit = YES;
        _animationWebView.scrollView.scrollEnabled = NO;
//        _animationWebView.scrollView.showsVerticalScrollIndicator = NO;
//        _animationWebView.scrollView.showsHorizontalScrollIndicator = NO;
        _animationWebView.opaque=NO;
        [_animationWebView setBackgroundColor:[UIColor clearColor]];
        [_animationWebView setHidden:YES];
        [self addSubview:_animationWebView];
    }
    return _animationWebView;
}

@end
