//
//  HMSku_propertiesModel.h
//  HuanMoney
//
//  Created by weplus on 16/9/10.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMSku_propertiesDetailModel;

@interface HMSku_propertiesModel : NSObject

/**
 *  id
 */
@property (copy, nonatomic) NSString *ID;

/**
 *  名字
 */
@property (copy, nonatomic) NSString *name;

/**
 *  具体选项
 */
@property (strong, nonatomic) NSArray <HMSku_propertiesDetailModel *>*values;

+ (instancetype)dataWithEmpty;

@end


@interface HMSku_propertiesDetailModel : NSObject

/**
 *  规格选择ID(具体选项)
 */
@property (copy, nonatomic) NSString *ID;

/**
 *  名字
 */
@property (copy, nonatomic) NSString *name;


/**
 该属性的所有库存 ---> 只要是规格拥有该属性,就会加到这个stock中
 */
@property (assign, nonatomic) NSInteger stock;

+ (instancetype)dataWithEmpty;

@end
