//
//  HMCategoriesModel.m
//  HuanMoney
//
//  Created by weplus on 16/9/2.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import "HMCategoriesModel.h"
//#import <MJExtension.h>

@implementation HMCategoriesModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID"    : @"id",
             @"CategoriesDescription" : @"description"
             };
}

- (instancetype)init {
    if (self = [super init]) {
        self.goodsArray = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithGoodsArray:(NSMutableArray <HMGoodsModel *>*)array ID:(NSString *)ID {
    if (self = [super init]) {
        self.goodsArray = array;
        self.ID = ID;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"id : %@, categoryName : %@, goodsArray : %@", self.ID, self.name, self.goodsArray];
}

@end
