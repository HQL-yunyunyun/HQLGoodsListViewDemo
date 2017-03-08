//
//  HMSku_propertiesModel.m
//  HuanMoney
//
//  Created by weplus on 16/9/10.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import "HMSku_propertiesModel.h"
//#import <MJExtension.h>

@implementation HMSku_propertiesModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID"    : @"id",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"values" : @"HMSku_propertiesDetailModel"
             };
}

+ (instancetype)dataWithEmpty {
    HMSku_propertiesModel *model = [HMSku_propertiesModel new];
    model.ID = @"";
    model.name = @"";
    model.values = @[[HMSku_propertiesDetailModel dataWithEmpty]];
    return model;
}

@end

@implementation HMSku_propertiesDetailModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID"    : @"id",
             };
}

+ (instancetype)dataWithEmpty {
    HMSku_propertiesDetailModel *model = [HMSku_propertiesDetailModel new];
    model.ID = @"";
    model.name = @"";
    return model;
}

@end
