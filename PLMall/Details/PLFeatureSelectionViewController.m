//
//  PLFeatureSelectionViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLFeatureSelectionViewController.h"

//Controllers
#import "PLFillinOrderViewController.h"
//Models
#import "PLFeatureItem.h"
#import "PLFeatureTitleItem.h"
#import "PLFeatureList.h"
//Views
#import "PPNumberButton.h"
#import "PLFeatureItemCell.h"
#import "PLFeatureHeaderView.h"
#import "PLCollectionHeaderLayout.h"
#import "PLFeatureChoseTopCell.h"
//Vendors
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "UIViewController+XWTransition.h"


#define NowScreenH ScreenH*0.8
@interface PLFeatureSelectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, HorizontalCollectionLayoutDelegate, PPNumberButtonDelegate, UITableViewDataSource, UITableViewDelegate>
//contionView
@property (nonatomic, strong) UICollectionView *collectionView;
//tableView
@property (nonatomic, strong) UITableView *tableView;
//数据
@property (nonatomic, strong) NSMutableArray<PLFeatureItem *> *featureAttr;
//选择属性
@property (nonatomic, strong) NSMutableArray *seleArray;
//商品选择结果Cell
@property (nonatomic, weak) PLFeatureChoseTopCell *cell;

@end

static NSInteger num;

static NSString *const PLFeatureHeaderViewID = @"PLFeatureHeaderView";
static NSString *const PLFeatureItemCellID = @"PLFeatureItemCell";
static NSString *const PLFeatureChoseTopCellID = @"PLFeatureChoseTopCell";
@implementation PLFeatureSelectionViewController
#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        PLCollectionHeaderLayout *layout = [PLCollectionHeaderLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 8;
        layout.interitemSpacing = PLMargin;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
        layout.itemInset = UIEdgeInsetsMake(0, PLMargin, 0, PLMargin);
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[PLFeatureItemCell class] forCellWithReuseIdentifier:PLFeatureItemCellID]; //cell
        [_collectionView registerClass:[PLFeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLFeatureHeaderViewID]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = 0;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        [_tableView registerNib:[PLFeatureChoseTopCell class] forCellReuseIdentifier:PLFeatureChoseTopCellID];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFeatureAlertView];
    [self setUpBase];
    [self setUpBottonView];
}
#pragma mark - initialize
- (void)setUpBase {
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _featureAttr = [PLFeatureItem mj_objectArrayWithFilename:@"ShopItem.plist"];
    self.tableView.frame = CGRectMake(0, 0, ScreenW, 100);
    self.tableView.rowHeight = 100;
    self.collectionView.frame = CGRectMake(0, self.tableView.pl_bottom, ScreenW, NowScreenH - 200);
    
    if (_lastSeleArray.count == 0) {
        return;
    }
    for (NSString *str in _lastSeleArray) {
        for (NSInteger i = 0; i < _featureAttr.count; i ++) {
            for (NSInteger j = 0; j <_featureAttr[i].list.count; j ++) {
                if ([_featureAttr[i].list[j].infoname isEqualToString:str]) {
                    _featureAttr[i].list[j].isSelect = YES;
                    [self.collectionView reloadData];
                }
            }
        }
    }
}
#pragma mark - 底部按钮
- (void)setUpBottonView {
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonH = 50;
    CGFloat buttonW = ScreenH/titles.count;
    CGFloat buttonY = NowScreenH - buttonH;
    
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : [UIColor orangeColor];
        CGFloat buttonX = buttonW*i;
        button.tag = i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:button];
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    UILabel *numLabel = [UILabel new];
    numLabel.text = @"数量";
    numLabel.font = PFR14Font;
    [self.view addSubview:numLabel];
    numLabel.frame = CGRectMake(PLMargin, NowScreenH - 90, 50, 35);
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(CGRectGetMaxX((numLabel.frame)), numLabel.pl_y, 110, numLabel.pl_height)];
    numberButton.shakeAnimation = YES;
    numberButton.minValue = 1;
    numberButton.inputFieldFont = 23;
    numberButton.increaseTitle = @"+";
    numberButton.decreaseTitle = @"-";
    num = (_lastNum == 0) ? 1 : _lastNum;
    numberButton.currentNumber = num;
    numberButton.delegate = self;
    
    numberButton.resultBlock = ^(NSInteger number, BOOL increaseStatus) {
        num = number;
    };
    [self.view addSubview:numberButton];
}
#pragma mark - 底部按钮点击
- (void)bottomButtonClick:(UIButton *)button {
    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {
        //未选择全属性警告
        [SVProgressHUD showInfoWithStatus:@"请选择全属性"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    [self dismissFeatureViewControllerWithTag:button.tag];
}
#pragma mark - 弹出弹框
- (void)setUpFeatureAlertView {
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    __weak typeof(self) weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint) {
        [weakSelf dismissFeatureViewControllerWithTag:100];
    } edgeSpacing:0];
}
#pragma mark - <UITableViewDataScorce>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLFeatureChoseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:PLFeatureChoseTopCellID forIndexPath:indexPath];
    _cell = cell;
    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {
        cell.chooseAttLabel.textColor = [UIColor redColor];
        cell.chooseAttLabel.text = @"有货";
    } else {
        cell.chooseAttLabel.textColor = [UIColor darkGrayColor];
        NSString *attString = (_seleArray.count == _featureAttr.count) ? [_seleArray componentsJoinedByString:@"，"] : [_lastSeleArray componentsJoinedByString:@"，"];
        cell.chooseAttLabel.text = [NSString stringWithFormat:@"已选属性：%@",attString];
    }
    cell.goodPriceLabel.text = [NSString stringWithFormat:@"￥%@",@"12"];
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:_goodImageView]];
    __weak typeof(self) weakSelf = self;
    cell.crossButtonClickBlock = ^{
        [weakSelf dismissFeatureViewControllerWithTag:100];
    };
    return cell;
}
#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithTag:(NSInteger)tag {
    __weak typeof(self) weakSelf = self;
    [weakSelf dismissViewControllerAnimated:YES completion:^{
        if (![weakSelf.cell.chooseAttLabel.text isEqualToString:@"有货"]) { //当选择全属性才传递出去
            if (_seleArray.count == 0) {
                NSMutableArray *numArray = [NSMutableArray arrayWithArray:_lastSeleArray];
                !weakSelf.userChooseBlock ? : weakSelf.userChooseBlock(numArray,num,tag);
            } else {
                !weakSelf.userChooseBlock ? : weakSelf.userChooseBlock(_seleArray,num,tag);
            }
        }
    }];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _featureAttr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _featureAttr[section].list.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLFeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLFeatureItemCellID forIndexPath:indexPath];
    cell.content = _featureAttr[indexPath.section].list[indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PLFeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLFeatureHeaderViewID forIndexPath:indexPath];
        headerView.headTitle = _featureAttr[indexPath.section].attr;
        return headerView;
    } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _featureAttr[indexPath.section].list[indexPath.row].isSelect = !_featureAttr[indexPath.section].list[indexPath.row].isSelect;
    //限制每组内的Item只能选中一个
    for (NSInteger j = 0; j < _featureAttr[indexPath.section].list.count; j ++) {
        _featureAttr[indexPath.section].list[j].isSelect = NO;
    }
    _featureAttr[indexPath.section].list[indexPath.row].isSelect = YES;
    //section，item循环将选中的所有item加入数组中，数组mutableCopy初始化
    _seleArray = [@[] mutableCopy];
    for (NSInteger i = 0; i < _featureAttr.count; i ++) {
        for (NSInteger j = 0; j < _featureAttr[i].list.count; j ++) {
            if (_featureAttr[i].list[j].isSelect == YES) {
                [_seleArray addObject:_featureAttr[i].list[j].infoname];
            }
        }
    }
    //刷新tableView和collectionView
    [collectionView reloadData];
    [self.tableView reloadData];
}
#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    return _featureAttr[indexPath.section].list[indexPath.row].infoname;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
