//
//  PLFootprintGoodsViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//
#define FootprintScreenW ScreenW*0.4

#import "PLFootprintGoodsViewController.h"
#import "PLRecomendItem.h"
#import "PLFootprintCell.h"
#import <MJExtension.h>
#import "UIViewController+XWTransition.h"
@interface PLFootprintGoodsViewController ()<UITableViewDataSource, UITableViewDelegate>
//整个足迹浏览View
@property (nonatomic, strong) UIView *footprintView;
//tableView
@property (nonatomic, strong) UITableView *tableView;
//足迹数据
@property (nonatomic, strong) NSMutableArray<PLRecomendItem *> *footprintItem;

@end
static NSString *PLFootprintCellID = @"PLFootprintCell";

@implementation PLFootprintGoodsViewController
#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[PLFootprintCell class] forCellReuseIdentifier:PLFootprintCellID];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFootprintAlertView];
    [self setUpInit];
    [self setUpHeadTitle];
    [self setUpData];
}
#pragma mark - initialize
- (void)setUpInit {
    self.view.backgroundColor = PLBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _footprintView = [[UIView alloc] init];
    _footprintView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_footprintView];
    [_footprintView addSubview:_tableView];
    
    _footprintView.frame = CGRectMake(0, 0, FootprintScreenW, ScreenH);
    
}
#pragma mark - 足迹数据
- (void)setUpData {
    _footprintItem = [PLRecomendItem mj_objectArrayWithFilename:@"FootprintGoods.plist"];
}
#pragma mark - 我的足迹
- (void)setUpHeadTitle {
    UILabel *myFootLabel = [[UILabel alloc] init];
    myFootLabel.text = @"我的足迹";
    myFootLabel.textAlignment = NSTextAlignmentCenter;
    myFootLabel.font = PFR15Font;
    
    [_footprintView addSubview:myFootLabel];
    myFootLabel.frame = CGRectMake(0, 20, FootprintScreenW, 44);
    _tableView.frame = CGRectMake(0, myFootLabel.pl_bottom, FootprintScreenW, ScreenH - myFootLabel.pl_bottom);
}
#pragma mark - 弹出弹框
- (void)setUpFootprintAlertView {
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionLeft;
    __weak typeof(self) weakSelf = self;
    [self xw_registerToInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint) {
        [weakSelf selfViewBack];
    } edgeSpacing:80];
}
#pragma mark - 退出当前View
- (void)selfViewBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _footprintItem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLFootprintCell *cell = [tableView dequeueReusableCellWithIdentifier:PLFootprintCellID forIndexPath:indexPath];
    cell.footprintItem = _footprintItem[indexPath.row];
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FootprintScreenW + 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了足迹的第%zd条数据",indexPath.row);
}

@end
