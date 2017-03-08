//
//  HMSkuModel.m
//  HuanMoney
//
//  Created by weplus on 16/9/2.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import "HMSkuModel.h"
//#import <MJExtension.h>

@implementation HMSkuModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID"    : @"id",
             @"skuDescription" : @"description"
             };
}

- (instancetype)initWithSkuModel:(HMSkuModel *)model {
    if (self = [super init]) {
        [self skuWithSkuModel:model];
    }
    return self;
}

- (void)skuWithSkuModel:(HMSkuModel *)model {
    self.brand_id = model.brand_id;
    self.brief_code = model.brief_code;
    self.category_ids = model.category_ids.copy;
    self.cost = model.cost;
    self.cost_range = model.cost_range.copy;
    self.created_at = model.created_at;
    self.skuDescription = model.skuDescription;
    self.favorite_count = model.favorite_count;
    self.galleries = model.galleries.copy;
    self.goods_id = model.goods_id;
    self.ID = model.ID;
    self.is_on_sale = model.is_on_sale;
    self.is_virtual = model.is_virtual;
    self.market_price = model.market_price;
    self.market_price_range = model.market_price_range.copy;
    self.member_price = model.member_price.copy;
    self.member_price_range = model.member_price_range.copy;
    self.memos = model.memos.copy;
    self.no = model.no;
    self.on_sale_time = model.on_sale_time;
    self.outer_no = model.outer_no;
    self.points = model.points;
    self.price = model.price;
    self.price_range = model.price_range.copy;
    self.price_slogan = model.price_slogan;
    self.promote_price = model.promote_price;
    self.promote_price_range = model.promote_price_range.copy;
    self.promotions = model.promotions.copy;
    self.properties = model.properties.copy;
    self.review_count = model.review_count;
    self.review_score = model.review_score;
    self.slogan = model.slogan;
    self.sold_count = model.sold_count;
    self.sort = model.sort;
    self.stock = model.stock;
    self.stock_count = model.stock_count;
    self.tag_ids = model.tag_ids;
    self.title = model.title;
    self.updated_at = model.updated_at;
    self.view_count = model.view_count;
//    self.currentNum = model.currentNum;
}

- (void)setPrice:(double)price {
    NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f", price]];
    _price = [num doubleValue];
}

@end
