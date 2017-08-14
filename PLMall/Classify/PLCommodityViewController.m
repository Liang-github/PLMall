//
//  PLCommodityViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//
#define tableViewH 100
#import "PLCommodityViewController.h"

//Controllers
#import "PLGoodsSetViewController.h"
//Models
#import "PLClassMainItem.h"
#import "PLClassSubItem.h"
#import "PLClassGoodsItem.h"
//Views
#import "PLNavSearchBarView.h"
#import "PLClassCategoryCell.h"
#import "PLGoodsSortCell.h"
#import "PLBrandSortCell.h"
#import "PLBrandsSortHeadView.h"
//Vendors
#import <MJExtension.h>
@interface PLCommodityViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<PLClassGoodsItem *> *titleItem;
@property (nonatomic, strong) NSMutableArray<PLClassMainItem *> *mainItem;

@end
static NSString *const PLClassCategoryCellID = @"PLClassCategoryCell";
static NSString *const PLBrandsSortHeadViewID = @"PLBrandsSortHeadView";
static NSString *const PLGoodsSortCellID = @"PLGoodsSortCell";
static NSString *const PLBrandSortCellID = @"PLBrandSortCell";
@implementation PLCommodityViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = 0;
        _tableView.frame = CGRectMake(0, PLTopNavH, tableViewH, ScreenH - PLTopNavH - PLBottomTabH);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[PLClassCategoryCell class] forCellReuseIdentifier:PLClassCategoryCellID];
    }
    return _tableView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 3;
        layout.minimumLineSpacing = 5;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewH, PLTopNavH, ScreenW - tableViewH, ScreenH - PLTopNavH - PLBottomTabH);
        //注册Cell
        [_collectionView registerClass:[PLGoodsSortCell class] forCellWithReuseIdentifier:PLGoodsSortCellID];
        [_collectionView registerClass:[PLBrandSortCell class] forCellWithReuseIdentifier:PLBrandSortCellID];
        //注册header
        [_collectionView registerClass:[PLBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLBrandsSortHeadViewID];
    }
    return _collectionView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.barTintColor == RGBA(231, 23, 37, 1)) {
        return;
    }
    self.navigationController.navigationBar.barTintColor = RGBA(231, 23, 37, 1);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpTab];
    [self setUpData];
}
- (void)setUpTab {
    self.view.backgroundColor = PLBGColor;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)setUpData {
    _titleItem = [PLClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
    _mainItem = [PLClassMainItem mj_objectArrayWithFilename:@"ClassiftyGoods01.plist"];
    //默认选择第一行（注意一定要在加载完数据之后）
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}
- (void)setUpNav {
    PLNavSearchBarView *searchBarVc = [[PLNavSearchBarView alloc] init];
    searchBarVc.placeholdLabel.text = @"快速查找商品";
    searchBarVc.frame = CGRectMake(20, 25, ScreenW - 40, 35);
    searchBarVc.voiceButtonClickBlock = ^{
        NSLog(@"语音点击回调");
    };
    searchBarVc.searchViewBlock = ^{
        NSLog(@"搜索");
    };
    self.navigationItem.titleView = searchBarVc;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleItem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:PLClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _mainItem = [PLClassMainItem mj_objectArrayWithFilename:_titleItem[indexPath.row].fileName];
    [self.collectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _mainItem.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mainItem[section].goods.count;
}
- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridCell = nil;
    if ([_mainItem[_mainItem.count - 1].title isEqualToString:@"热门品牌"]) {
        if (indexPath.section == _mainItem.count - 1) {
            //品牌
            PLBrandSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLBrandSortCellID forIndexPath:indexPath];
            cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
            gridCell = cell;
        } else {
            //商品
            PLGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsSortCellID forIndexPath:indexPath];
            cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
            gridCell = cell;
        }
    } else {
        //商品
        PLGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsSortCellID forIndexPath:indexPath];
        cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
        gridCell = cell;
    }
    return gridCell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        PLBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLBrandsSortHeadViewID forIndexPath:indexPath];
        headerView.headTitle = _mainItem[indexPath.section];
        reusableView = headerView;
    }
    return reusableView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_mainItem[_mainItem.count - 1].title isEqualToString:@"热门品牌"]) {
        if (indexPath.section == _mainItem.count - 1) {
            //品牌
            return CGSizeMake((ScreenW - tableViewH - 6)/3, 60);
        } else {
            //商品
            return CGSizeMake((ScreenW - tableViewH - 6)/3, (ScreenW - tableViewH - 6)/3 + 20);
        }
    } else {
        return CGSizeMake((ScreenW - tableViewH - 6)/3, (ScreenH - tableViewH - 6)/3 + 20);
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 25);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
- (void)tableView:(UITableView *)tableView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%zd分组第%zd个item",indexPath.section,indexPath.row);
    PLGoodsSetViewController *goodSetVc = [[PLGoodsSetViewController alloc] init];
    goodSetVc.goodPlistName = @"ClasiftyGoods.plist";
    [self.navigationController pushViewController:goodSetVc animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
