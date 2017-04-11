//
//  HQLGoodsListView.m
//  HQLGoodsListViewDemo
//
//  Created by weplus on 2017/3/6.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "HQLGoodsListView.h"
#import "HMCategoriesModel.h"
#import "HMGoodsModel.h"
#import "HMGoodsListCell.h"

#import "UITableView+EmptyView.h"

#import "UIView+ZXFrameExtension.h"

#define ZXColor( r, g, b) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1]

#define kRightCellReuseID @"kRightCellReuseID"
#define kLeftCellReuseID @"kLeftCellReuseID"
#define kSingleCategoryID @"8008208820"

@interface HQLGoodsListView () <UITableViewDelegate, UITableViewDataSource, HMGoodsListCellDelegate>

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

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftTableView.height = self.height;
    self.rightTableView.height = self.height;
}

- (void)dealloc {
    NSLog(@"dealloc ---> %@",NSStringFromClass([self class]));
}

#pragma mark - event

- (void)reloadData {
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

- (void)setEdit:(BOOL)isEdit {
    for (HMGoodsListCell *cell in [self.rightTableView visibleCells]) {
        [cell setEdit:isEdit];
    }
}

#pragma mark - table view delegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 50;
    } else if (tableView == self.rightTableView) {
        return 60;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        // 刷新self.rightTable
        [self.rightTableView reloadData];
    } else if (tableView == self.rightTableView) {
        // 代理
        NSIndexPath *targetIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:[self.leftTableView indexPathForSelectedRow].row];
        if ([self.delegate respondsToSelector:@selector(goodsListView:tableView:didSelectRowAtIndexPath:)]) {
            [self.delegate goodsListView:self tableView:self.rightTableView didSelectRowAtIndexPath:targetIndexPath];
        }
    } else {
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0000001;
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // 两个tableView都是一组
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.leftTableView == tableView) {
        return self.dataSource.count;
    } else if (self.rightTableView == tableView) {
        // 根据商品类中的商品数量
        HMCategoriesModel *model = self.dataSource[[self.leftTableView indexPathForSelectedRow].row];
        return model.goodsArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftCellReuseID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLeftCellReuseID];
            cell.backgroundColor = ZXColor(240, 240, 240);
            UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = selectedBackgroundView;
            // 左侧示意条
            UIView *liner = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 3, 50)];
            liner.backgroundColor = [UIColor orangeColor];
            [selectedBackgroundView addSubview:liner];
        }
        HMCategoriesModel *model = self.dataSource[indexPath.row];
        NSString *sting = [model.ID isEqualToString:kSingleCategoryID] ? @"全部" : model.name;
        cell.textLabel.text = sting;
        return cell;
    } else if (tableView == self.rightTableView) {
        HMGoodsListCell *cell = (HMGoodsListCell *)[tableView dequeueReusableCellWithIdentifier:kRightCellReuseID];
        cell.cellMode = HQLGoodsListCellManageMode;
        cell.delegate = self;
        NSMutableArray *goodsArray = [self.dataSource[indexPath.section] goodsArray];
        cell.model = goodsArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return nil;
    }
}

#pragma mark - goods list cell delegate

- (void)goodsListCell:(HMGoodsListCell *)cell didClickButton:(UIButton *)btn buttonType:(buttonType)buttonType {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.rightTableView indexPathForCell:cell].row inSection:[self.leftTableView indexPathForSelectedRow].row];
    if ([self.delegate respondsToSelector:@selector(goodsListView:tableView:listCellDidClickButton:buttonType:indexPath:)]) {
        [self.delegate goodsListView:self tableView:self.rightTableView listCellDidClickButton:btn buttonType:buttonType indexPath:indexPath];
    }
}

#pragma mark - tool

- (UITableView *)setupTableViewWithX:(CGFloat)tableVeiwX width:(CGFloat)width {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableVeiwX, 0, width, self.frame.size.height)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40;
    tableView.separatorColor = ZXColor(230, 230, 230);
    tableView.bounces = NO;
    [self addSubview:tableView];
    return tableView;
}

#pragma mark - setter

- (void)setDataSource:(NSMutableArray<HMCategoriesModel *> *)dataSource {
    // 如果第一个categoriesModel的id不是singleCategoryID 就返回
    HMCategoriesModel *model = dataSource.firstObject;
    NSAssert(![model.ID isEqualToString:kSingleCategoryID], @"dataSource 的第一个元素一定要是全部商品");
    _dataSource = dataSource;
    
    [self reloadData];
}

#pragma mark - getter

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        CGFloat leftTableViewWidth = self.frame.size.width * 0.25;
        CGFloat rightTableViewWidth = self.frame.size.width - leftTableViewWidth;
        CGFloat rightTableViewX = leftTableViewWidth;
        UITableView *rightTableView = [self setupTableViewWithX:rightTableViewX width:rightTableViewWidth];
        [rightTableView registerNib:[UINib nibWithNibName:@"HMGoodsListCell" bundle:nil] forCellReuseIdentifier:kRightCellReuseID];
        rightTableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _rightTableView = rightTableView;
        
        rightTableView.emptyTapBlock = ^{
            NSLog(@"tap right table view");
        };
        rightTableView.isUseEmptyView = YES;
        rightTableView.emptyViewTitle = @"仓库为空哦，请添加商品啦，喵";
    }
    return _rightTableView;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        CGFloat leftTableViewWidth = self.frame.size.width * 0.25;
        UITableView *leftTableView = [self setupTableViewWithX:0 width:leftTableViewWidth];
        leftTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _leftTableView = leftTableView;
        
        leftTableView.emptyTapBlock = ^{
            NSLog(@"tap left table view");
        };
        leftTableView.isUseEmptyView = YES;
        leftTableView.emptyViewTitle = @"唔。。。为空，请添加商品哦";
    }
    return _leftTableView;
}

@end
