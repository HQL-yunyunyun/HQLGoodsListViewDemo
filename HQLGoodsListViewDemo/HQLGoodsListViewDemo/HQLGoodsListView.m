//
//  HQLGoodsListView.m
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/6.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "HQLGoodsListView.h"

//#import "UITableView+EmptyView.h"

@interface HQLGoodsListView () <UITableViewDelegate, UITableViewDataSource>

/**
 左边的tableView ---> 显示商品的类别
 */
@property (strong, nonatomic) UITableView *leftTableView;

/**
 右半的tableView
 */
@property (strong, nonatomic) UITableView *rightTableView;

@end

@implementation HQLGoodsListView

#pragma mark - initialization

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self leftTableView];
        [self rightTableView];
        
        [self reloadData];
    }
    return self;
}

#pragma mark - event

- (void)reloadData {
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

#pragma mark - table view delegate 

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.leftTableView == tableView) {
        return self.dataSource.count;
    } else if (self.rightTableView == tableView) {
        // 根据商品类中的商品数量
        return 0;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell"];
    cell.textLabel.text = @"test";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

#pragma mark - tool

- (UITableView *)setupTableViewWithX:(CGFloat)tableVeiwX width:(CGFloat)width {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableVeiwX, 0, width, self.frame.size.height)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40;
//    tableView.separatorColor = ZXColor(230, 230, 230);
    tableView.bounces = NO;
    [self addSubview:tableView];
    return tableView;
}

#pragma mark - getter

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        CGFloat leftTableViewWidth = self.frame.size.width * 0.25;
        CGFloat rightTableViewWidth = self.frame.size.width - leftTableViewWidth;
        CGFloat rightTableViewX = leftTableViewWidth;
        UITableView *rightTableView = [self setupTableViewWithX:rightTableViewX width:rightTableViewWidth];
//        [rightTableView registerNib:[UINib nibWithNibName:@"HMGoodsListCell" bundle:nil] forCellReuseIdentifier:kRightCellReuseID];
        rightTableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _rightTableView = rightTableView;
    }
    return _rightTableView;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        CGFloat leftTableViewWidth = self.frame.size.width * 0.25;
        UITableView *leftTableView = [self setupTableViewWithX:0 width:leftTableViewWidth];
        leftTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _leftTableView = leftTableView;
    }
    return _leftTableView;
}

@end
