//
//  HMSkuModel.h
//  HuanMoney
//
//  Created by weplus on 16/9/2.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMSkuModel;

@interface HMSkuModel : NSObject

/**
 *  品牌ID
 */
@property (copy, nonatomic) NSString *brand_id;

/**
 *  简码
 */
@property (copy, nonatomic) NSString *brief_code;

/**
 *  分类ids
 */
@property (strong, nonatomic) NSArray *category_ids;

/**
 *  消费金额
 */
@property (assign, nonatomic) double cost;

/**
 *  消费金额区间
 */
@property (strong, nonatomic) NSArray *cost_range;

/**
 *  创建时间
 */
@property (copy, nonatomic) NSString *created_at;

/**
 *  商品描述
 */
@property (copy, nonatomic) NSString *skuDescription;

/**
 *  favorite count
 */
@property (copy, nonatomic) NSString *favorite_count;

/**
 *  图片集
 */
@property (strong, nonatomic) NSArray *galleries;

/**
 *  该sku从属的商品id
 */
@property (copy, nonatomic) NSString *goods_id;

/**
 *  sku的ID
 */
@property (copy, nonatomic) NSString *ID;

/**
 *  是否在售
 */
@property (assign, nonatomic) BOOL is_on_sale;

/**
 *  是否为虚拟商品
 */
@property (assign, nonatomic) BOOL is_virtual;

/**
 *  市场价格
 */
@property (assign, nonatomic) double market_price;

/**
 *  市场价价格范围
 */
@property (strong, nonatomic) NSArray *market_price_range;

/**
 *  会员价
 */
@property (copy, nonatomic) NSArray *member_price;

/**
 *  会员价价格范围
 */
@property (strong, nonatomic) NSArray *member_price_range;

/**
 *  备注
 */
@property (strong, nonatomic) NSArray *memos;

@property (copy, nonatomic) NSString *no;

@property (copy, nonatomic) NSString *on_sale_time;

@property (copy, nonatomic) NSString *outer_no;

/**
 *  积分
 */
@property (assign, nonatomic) NSInteger points;

/**
 *  价格
 */
@property (assign, nonatomic) double price;

/**
 *  价格范围
 */
@property (strong, nonatomic) NSArray *price_range;

@property (copy, nonatomic) NSString *price_slogan;

/**
 *  优惠价
 */
@property (assign, nonatomic) double promote_price;

/**
 *  优惠价价格范围
 */
@property (strong, nonatomic) NSArray *promote_price_range;

/**
 *  优惠
 */
@property (strong, nonatomic) NSArray *promotions;

/**
 *  该 sku 包含的规格 - 规格值对应表
 */
@property (strong, nonatomic) NSDictionary *properties;

@property (assign, nonatomic) NSInteger review_count;

@property (assign, nonatomic) NSInteger review_score;

/**
 *  该sku包含的所有规格和他们的规格值
 */
//@property (strong, nonatomic) NSArray *sku_properties;

/**
 *  促销口号
 */
@property (copy, nonatomic) NSString *slogan;

/**
 *  销售次数
 */
@property (assign, nonatomic) NSInteger sold_count;

/**
 *  排序
 */
@property (copy, nonatomic) NSString *sort;

/**
 *  库存
 */
@property (assign, nonatomic) NSInteger stock;

/**
 *  总库存,所有sku的库存相加
 */
@property (assign, nonatomic) NSInteger stock_count;

/**
 *  标签ids
 */
@property (strong, nonatomic) NSArray *tag_ids;

/**
 *  商品名称
 */
@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *updated_at;

/**
 *  浏览次数
 */
@property (assign, nonatomic) NSInteger view_count;

/**
 当前sku被持有的商品数量(放到购物车中)
 */
//@property (assign, nonatomic) NSInteger currentNum;

- (instancetype)initWithSkuModel:(HMSkuModel *)model;

- (void)skuWithSkuModel:(HMSkuModel *)model;

@end
