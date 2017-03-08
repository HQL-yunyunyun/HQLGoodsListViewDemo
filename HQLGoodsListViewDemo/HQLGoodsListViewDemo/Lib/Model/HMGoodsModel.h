//
//  HMGoodsModel.h
//  HuanMoney
//
//  Created by weplus on 16/9/1.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMGoodsMemoModel;

@interface HMGoodsModel : NSObject

/**
 *  品牌id
 */
@property (copy, nonatomic) NSString *brand_id;

@property (copy, nonatomic) NSString *brief_code;

/**
 *  分类id数组
 */
@property (strong, nonatomic) NSArray *category_ids;

/**
 *  消费金额
 */
@property (assign, nonatomic) double cost;

/**
 *  消费范围
 */
@property (strong, nonatomic) NSArray *cost_range;

/**
 *  创建时间
 */
@property (copy, nonatomic) NSString *created_at;

/**
 *  图片数组(内含几个应用场景不同的图片url)
 */
@property (strong, nonatomic) NSArray *galleries;

/**
 *  goods id
 */
@property (copy, nonatomic) NSString *ID;

/**
 *  是否在售
 */
@property (assign, nonatomic) BOOL is_on_sale;

/**
 *  是否为虚拟产品
 */
@property (assign, nonatomic) BOOL is_virtual;

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
@property (strong, nonatomic) NSArray <HMGoodsMemoModel *>*memos;

@property (copy, nonatomic) NSString *multiple;

@property (copy, nonatomic) NSString *on_sale_time;

/**
 *  积分
 */
@property (assign, nonatomic) NSInteger points;

/**
 *  价格范围
 */
@property (strong, nonatomic) NSArray *price_range;

/**
 *  促销口号
 */
@property (copy, nonatomic) NSString *price_slogan;

/**
 *  优惠价格
 */
@property (assign, nonatomic) double promote_price;

/**
 *  优惠价格范围
 */
@property (strong, nonatomic) NSArray *promote_price_range;

/**
 *  优惠
 */
@property (strong, nonatomic) NSArray *promotions;

/**
 *  sku所有的规格选择
 */
@property (strong, nonatomic) NSArray *sku_properties;

/**
 *  规格
 */
@property (strong, nonatomic) NSArray *skus;

/**
 *  口号
 */
@property (copy, nonatomic) NSString *slogan;

/**
 *  总库存
 */
@property (copy, nonatomic) NSString *stock_count;

/**
 *  标签数组
 */
@property (strong, nonatomic) NSArray *tag_ids;

/**
 *  商品名字
 */
@property (copy, nonatomic) NSString *title;

/**
 *  更新时间
 */
@property (copy, nonatomic) NSString *updated_at;

/**
 *  用户添加到购物车的数量
 */
@property (assign, nonatomic) NSInteger selectedCount;

/**
 检索字符串
 */
@property (copy, nonatomic) NSString *retrievalString;

/**
 小写英文
 */
@property (copy, nonatomic) NSString *lowerString;

/**
 *  在分类当中,持有的goodsModel的indexpath
 */
@property (strong, nonatomic) NSMutableArray <NSIndexPath *>*indexPathArray;

// 是否选择 是否编辑
@property (assign, nonatomic) BOOL HQL_isSelected;
@property (assign, nonatomic) BOOL HQL_isEdit;

- (instancetype)initWithGoodsModel:(HMGoodsModel *)model;

- (void)goodsWithGoodsModel:(HMGoodsModel *)model;

/**
 中文转拼音

 @param chinese 需要转换的中文

 @return 转换后的拼音
 */
+ (NSString *)transform:(NSString *)chinese;

// 更新sku_properts的库存
- (void)updateSku_propertsStock;

@end

@interface HMGoodsMemoModel : NSObject

@property (copy, nonatomic) NSString *alias;

@property (copy, nonatomic) NSString *ID;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *pinyin;

@end
