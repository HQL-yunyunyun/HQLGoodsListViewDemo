//
//  UITableView+EmptyView.m
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/7.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "UITableView+EmptyView.h"
#import <objc/runtime.h>

static const NSString *HQLEmptyViewImageKey = @"HQLEmptyViewImageKey";
static const NSString *HQLEmptyViewTitleKey = @"HQLEmptyViewTitleKey";
static const NSString *HQLEmptyViewTapBlockKey= @"HQLEmptyViewTapBlockKey";
static const NSString *HQLIsUseEmptyViewKey = @"HQLIsUseEmptyViewKey";
static const NSString *HQLEmptyViewKey = @"HQLEmptyViewKey";

#define kEmptyViewTag 1101

@implementation UITableView (EmptyView)

#pragma mark - system method

+ (void)load {
    [super load];
    Method fromMethod = class_getInstanceMethod([self class], @selector(reloadData));
    Method toMethod = class_getInstanceMethod([self class], @selector(HQL_reloadData));
    method_exchangeImplementations(fromMethod, toMethod);
    
    Method layoutFromMethod = class_getInstanceMethod([self class], @selector(layoutSubviews));
    Method layoutToMethod = class_getInstanceMethod([self class], @selector(HQL_layoutSubViews));
    method_exchangeImplementations(layoutFromMethod, layoutToMethod);
    
//    Method deallocFromMethod = class_getInstanceMethod([self class], @selector(dealloc));
//    Method deallocToMethod = class_getInstanceMethod([self class], @selector(HQL_dealloc));
    
}

#pragma mark - method swizzling

//- (void)HQL_dealloc {
//    [self HQL_dealloc];
//    
//    [self.emptyView removeFromSuperview];
//    self.emptyView = nil;
//}

- (void)HQL_layoutSubViews {
    [self HQL_layoutSubViews];
    
    // 设置empty的frame
    self.emptyView.frame = self.bounds;
    NSLog(@"empty view :%@", self.emptyView);
}

- (void)HQL_reloadData {
    [self HQL_reloadData];
    
    if (!self.isUseEmptyView) {
        self.emptyView.hidden = YES;
        return;
    }
    // 如果 row为0 且headerView和footerView都为空 --- 可以判断sectionHeaderHeight 和 sectionFooterHeight
    if (self.sectionHeaderHeight > 1 || self.sectionFooterHeight > 1) {
        self.emptyView.hidden = YES;
        return;
    }
    
    NSInteger row = 0;
    for (int i = 0; i < self.numberOfSections; i++) {
        row += [self numberOfRowsInSection:i];
    }
    if (row > 0) { // row不为0 表明有数据
        self.emptyView.hidden = YES;
        return;
    }
    
    // 到这就可以表明没有数据了 --- > 设置emptyView
    [self.emptyView setHidden:NO];
    
    NSLog(@"empty view :%@", self.emptyView);
}

#pragma mark - setter 

- (void)setEmptyView:(HQLEmptyView *)emptyView {
    if (emptyView.tag == kEmptyViewTag) {
        objc_setAssociatedObject(self, &HQLEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setEmptyViewImage:(UIImage *)emptyViewImage {
    self.emptyView.image = emptyViewImage;
    objc_setAssociatedObject(self, &HQLEmptyViewImageKey, emptyViewImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setEmptyViewTitle:(NSString *)emptyViewTitle {
    self.emptyViewTitle = emptyViewTitle;
    objc_setAssociatedObject(self, &HQLEmptyViewTitleKey, emptyViewTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEmptyTapBlock:(void (^)())emptyTapBlock {
    self.emptyView.tapBlock = emptyTapBlock;
    objc_setAssociatedObject(self, &HQLEmptyViewTapBlockKey, emptyTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setIsUseEmptyView:(BOOL)isUseEmptyView {
    objc_setAssociatedObject(self, &HQLIsUseEmptyViewKey, [NSNumber numberWithBool:isUseEmptyView], OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - getter

- (UIImage *)emptyViewImage {
    return objc_getAssociatedObject(self, &HQLEmptyViewImageKey);
}

- (NSString *)emptyViewTitle {
    return objc_getAssociatedObject(self, &HQLEmptyViewTitleKey);
}

- (void (^)())emptyTapBlock {
    return objc_getAssociatedObject(self, &HQLEmptyViewTapBlockKey);
}

- (BOOL)isUseEmptyView {
    return objc_getAssociatedObject(self, &HQLIsUseEmptyViewKey);
}

- (HQLEmptyView *)emptyView {
    HQLEmptyView *view = objc_getAssociatedObject(self, &HQLEmptyViewKey);
    if (view) {
        return view;
    } else {
        HQLEmptyView *emtpyView = [[HQLEmptyView alloc] init];
        emtpyView.frame = self.bounds;
        emtpyView.tag = kEmptyViewTag;
        
        emtpyView.hidden = YES;
//        emtpyView.image = [UIImage imageNamed:<#(nonnull NSString *)#>]
        emtpyView.title = @"没有数据诶，喵";
        
        [self addSubview:emtpyView];
        [self setEmptyView:emtpyView];
    }
    
    return objc_getAssociatedObject(self, &HQLEmptyViewKey);
}

@end
