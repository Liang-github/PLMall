//
//  PLReceiverAdressViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLReceiverAdressViewController.h"
#import "PLAddressItem.h"
#import "PLReceiverAddressCell.h"
#import <MJExtension.h>
#import "UIBarButtonItem+PLBarButtonItem.h"

@interface PLReceiverAdressViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<PLAddressItem *> *addItem;
@end

static NSString *const PLReceiverAddressCellID = @"PLReceiverAddressCell";

@implementation PLReceiverAdressViewController

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = 0;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.frame = CGRectMake(0, PLTopNavH, ScreenW, ScreenH - PLTopNavH);
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[PLReceiverAddressCell class] forCellReuseIdentifier:PLReceiverAddressCellID];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTab];
    [self setUpNav];
    [self setUpAddressData];
}
- (void)setUpTab {
    self.view.backgroundColor = PLBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setUpNav {
    self.title = @"收货地址管理";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"jr_add"] withHighlighted:[UIImage imageNamed:@"jr_add"] target:self action:@selector(addItemClick)];
}
#pragma mark - 地址数据
- (void)setUpAddressData {
    _addItem = [PLAddressItem mj_objectArrayWithFilename:@"DeliveryAdress.plist"];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addItem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLReceiverAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:PLReceiverAddressCellID forIndexPath:indexPath];
    cell.adItem = _addItem[indexPath.row];
    
    cell.defaultClickBlock = ^{
        NSLog(@"点击了默认地址");
    };
    cell.delectClickBlock = ^{
        NSLog(@"点击了删除");
    };
    cell.editClickBlock = ^{
        NSLog(@"点击了编辑");
    };
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _addItem[indexPath.row].cellHeight;
}
#pragma mark - 添加地址
- (void)addItemClick {
    
}
@end
