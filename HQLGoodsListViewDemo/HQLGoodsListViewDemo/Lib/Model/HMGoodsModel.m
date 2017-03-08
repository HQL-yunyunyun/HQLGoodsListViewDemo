//
//  HMGoodsModel.m
//  HuanMoney
//
//  Created by weplus on 16/9/1.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import "HMGoodsModel.h"
#import "HMSkuModel.h"
#import "HMSku_propertiesModel.h"
//#import <MJExtension.h>

@implementation HMGoodsModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID"    : @"id",
             };
}

// 实现这个方法：key对应属性中的array,value对应着数组成员的模型class
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"sku_properties" : @"HMSku_propertiesModel",
             @"skus" : @"HMSkuModel",
             @"memos" : @"HMGoodsMemoModel"
             };
}

/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"selectedCount", @"indexPathArray", @"retrievalString", @"lowerString"];
}

+ (NSString *)transform:(NSString *)chinese {
    return [[HMGoodsModel new] transform:chinese];
}

- (instancetype)initWithGoodsModel:(HMGoodsModel *)model {
    if (self = [super init]) {
        [self goodsWithGoodsModel:model];
    }
    return self;
}

- (void)goodsWithGoodsModel:(HMGoodsModel *)model {
    self.brand_id = model.brand_id;
    self.brief_code = model.brief_code;
    self.category_ids = model.category_ids.mutableCopy;
    self.cost = model.cost;
    self.cost_range = model.cost_range.mutableCopy;
    self.created_at = model.created_at;
    self.galleries = model.galleries.mutableCopy;
    self.ID = model.ID;
    self.is_on_sale = model.is_on_sale;
    self.is_virtual = model.is_virtual;
    self.market_price_range = model.market_price_range.mutableCopy;
    self.member_price = model.member_price.copy;
    self.member_price_range = model.member_price_range.mutableCopy;
    self.memos = model.memos.mutableCopy;
    self.multiple = model.multiple;
    self.on_sale_time = model.on_sale_time;
    self.points = model.points;
    self.price_range = model.price_range.mutableCopy;
    self.price_slogan = model.price_slogan;
    self.promote_price = model.promote_price;
    self.promote_price_range = model.promote_price_range.mutableCopy;
    self.promotions = model.promotions.mutableCopy;
    self.sku_properties = model.sku_properties.mutableCopy;
    if (self.skus.count == 0 || !self.skus) {
        self.skus = model.skus;
    } else {
        for (int i = 0; i < model.skus.count; i++) {
            HMSkuModel *selfSku = self.skus[i];
            HMSkuModel *modelSku = model.skus[i];
            [selfSku skuWithSkuModel:modelSku];
        }
    }
    self.slogan = model.slogan;
    self.stock_count = model.stock_count;
    self.tag_ids = model.tag_ids.mutableCopy;
    self.title = model.title;
    self.updated_at = model.updated_at;
    self.selectedCount = model.selectedCount;
    self.indexPathArray = model.indexPathArray.mutableCopy;
    self.retrievalString = model.retrievalString;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"title"]) {
        self.retrievalString = [self transform:value];
        NSString *string = (NSString *)value;
        self.lowerString = [[string lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
//        ZXLog(@"retrievalString : %@ lowerString:%@",self.retrievalString, self.lowerString);
    } else if ([key isEqualToString:@"skus"] || [key isEqualToString:@"sku_properties"]) {
        [self updateSku_propertsStock];
    }
}

- (void)updateSku_propertsStock {
    if ( self.sku_properties.count != 0 && self.sku_properties && self.sku_properties.count != 0 && self.skus) {
        for (HMSku_propertiesModel *sku_propert in self.sku_properties) {
            for (HMSku_propertiesDetailModel *sku_detail in sku_propert.values) {
                sku_detail.stock = 0;
                for (HMSkuModel *sku in self.skus) {
                    for (NSString *sku_detail_id in [sku.properties allValues]) {
                        if ([sku_detail_id isEqualToString:sku_detail.ID]) {
                            sku_detail.stock += sku.stock;
                        }
                    }
                }
            }
        }
    }
}

- (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    pinyin = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""].mutableCopy;
    return [pinyin lowercaseString].copy;
}

@end

@implementation HMGoodsMemoModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID"    : @"id",
             };
}

@end
