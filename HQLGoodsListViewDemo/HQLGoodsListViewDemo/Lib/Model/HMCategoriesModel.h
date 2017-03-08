//
//  HMCategoriesModel.h
//  HuanMoney
//
//  Created by weplus on 16/9/2.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMGoodsModel;

@interface HMCategoriesModel : NSObject

/**
 *  分类id
 */
@property (copy, nonatomic) NSString *ID;

/**
 *  父id
 */
@property (copy, nonatomic) NSString *parent_id;

/**
 *  分类名
 */
@property (copy, nonatomic) NSString *name;

/**
 *  分类logo,各种图片URL
 */
@property (strong, nonatomic) NSDictionary *logo;

@property (copy, nonatomic) NSString *title;

/**
 *  销售口号
 */
@property (copy, nonatomic) NSString *slogan;

/**
 *  关键字
 */
@property (copy, nonatomic) NSString *keywords;

/**
 *  分类描述
 */
@property (copy, nonatomic) NSString *CategoriesDescription;

/**
 *  排序
 */
@property (copy, nonatomic) NSString *sort;

/**
 *  该分类下的商品数组
 */
@property (strong, nonatomic) NSMutableArray <HMGoodsModel *>*goodsArray;

- (instancetype)initWithGoodsArray:(NSMutableArray <HMGoodsModel *>*)array ID:(NSString *)ID;

@end
