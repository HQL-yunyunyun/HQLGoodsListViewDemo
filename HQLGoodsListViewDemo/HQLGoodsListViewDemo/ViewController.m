//
//  ViewController.m
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/6.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "ViewController.h"

#import "HQLGoodsListView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:[[HQLGoodsListView alloc] initWithFrame:CGRectMake(0, 100, 325, 200)]];
}


- (void)test {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"test 44");
    });
    
    [self performSelector:@selector(test33) withObject:nil afterDelay:0];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"test 55");
    });
    
    [self performSelector:@selector(test22)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"test 66");
    });
    [self test11];
}

- (void)test11 {
    NSLog(@"test11");
}

- (void)test22 {
    NSLog(@"test22");
}

- (void)test33 {
    NSLog(@"test33");
}


@end
