//
//  HQLNumberButton.h
//  numberButtonDemo
//
//  Created by weplus on 16/8/31.
//  Copyright © 2016年 weplus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    HQLNumberButtonPatternButton = 0, // 当作为button时的模式
    HQLNumberButtonPatternView           // 当作为view时的模式
    
} HQLNumberButtonPattern;

@interface HQLNumberButton : UIButton

/**
 *  button的样式 默认为button样式
 */
@property (assign, nonatomic) HQLNumberButtonPattern buttonPattern;

@property (assign, nonatomic) NSInteger num;

- (void)animationStart;

//- (void)setNumber:(NSInteger)num;

@end
