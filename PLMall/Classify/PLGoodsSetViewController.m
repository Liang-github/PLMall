//
//  PLGoodsSetViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLGoodsSetViewController.h"

//Controllers
#import "PLFootprintGoodsViewController.h"
#import "PLGoodDetailViewController.h"
#import "PLFiltrateViewController.h"
//Models
#import "PLRecomendItem.h"
//Views
#import "PLNavSearchBarView.h"
#import "PLCustionHeadView.h"
#import "PLSwitchGridCell.h"
#import "PLListGridCell.h"
#import "PLColonInsView.h"

#import "PLHoverFlowLayout.h"
//Vendors
#import <MJExtension.h>
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

@interface PLGoodsSetViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
//切换视图按钮
@property (nonatomic, strong) UIButton *switchViewButton;
@property (nonatomic, strong) PLCustionHeadView *custionHeadView;
@property (nonatomic, strong) NSMutableArray<PLRecomendItem *> *setItem;
@property (nonatomic, strong) PLColonInsView *colonView;
@property (nonatomic, assign) BOOL isSwitchGrid;
@property (nonatomic, strong) UIButton *backTopButton;
@property (nonatomic, strong) UIButton *footprintButton;

@end
static CGFloat lastContentOffset;
static NSString *const PLCustionHeadViewID = @"PLCustionHeadView";
static NSString *const PLSwitchGridCellID = @"PLSwitchGridCell";
static NSString *const PLListGridCellID = @"PLListGridCell";
@implementation PLGoodsSetViewController
- (NSString *)goodPlistName {
    return nil;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        PLHoverFlowLayout *layout = [PLHoverFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, PLTopNavH, ScreenW, ScreenH - PLTopNavH);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[PLCustionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLCustionHeadViewID]; //头部View
        [_collectionView registerClass:[PLSwitchGridCell class] forCellWithReuseIdentifier:PLSwitchGridCellID];
        [_collectionView registerClass:[PLListGridCell class] forCellWithReuseIdentifier:PLListGridCellID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.barTintColor == PLBGColor) {
        return;
    }
    self.navigationController.navigationBar.barTintColor = PLBGColor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpColl];
    [self setUpData];
    [self setUpSuspendView];
}
- (void)setUpColl {
    _isSwitchGrid = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = PLBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
}
- (void)setUpData {
    _setItem = [PLRecomendItem mj_objectArrayWithFilename:_goodPlistName];
}
- (void)setUpNav {
    _switchViewButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 50, 10, 44, 44)];
    _switchViewButton.imageEdgeInsets = UIEdgeInsetsMake(0, PLMargin, 0, 0);
    [_switchViewButton setImage:[UIImage imageNamed:@"nav_btn_jiugongge"] forState:0];
    [_switchViewButton setImage:[UIImage imageNamed:@"nav_btn_list"] forState:UIControlStateSelected];
    [_switchViewButton addTarget:self action:@selector(switchViewButtonBarItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_switchViewButton];
    
    PLNavSearchBarView *searchBarVc = [[PLNavSearchBarView alloc] init];
    searchBarVc.placeholdLabel.text = @"快速查找商品";
    searchBarVc.frame = CGRectMake(40, 25, ScreenW - 120, 35);
    searchBarVc.voiceImageBtn.hidden = YES;
    searchBarVc.searchViewBlock = ^{
        NSLog(@"搜索");
    };
    self.navigationItem.titleView = searchBarVc;
}
- (void)setUpSuspendView {
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:0];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 60, 40, 40);
    
    _footprintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_footprintButton];
    [_footprintButton addTarget:self action:@selector(footprintButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_footprintButton setImage:[UIImage imageNamed:@"ptgd_icon_zuji"] forState:0];
    _footprintButton.frame = CGRectMake(ScreenW - 50, ScreenH - 60, 40, 40);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _setItem.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLListGridCell *cell = nil;
    cell = (_isSwitchGrid) ? [collectionView dequeueReusableCellWithReuseIdentifier:PLListGridCellID forIndexPath:indexPath] : [collectionView dequeueReusableCellWithReuseIdentifier:PLSwitchGridCellID forIndexPath:indexPath];
    cell.youSelectItem = _setItem[indexPath.row];
    
    __weak typeof(self)weakSelf = self;
    if (_isSwitchGrid) { //列表Cell
        __weak typeof(cell)weakCell = cell;
        cell.colonClickBlock = ^{ // 冒号点击
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf setUpColonInsView:weakCell];
            [strongSelf.colonView setUpUI]; // 初始化
            strongSelf.colonView.collectionBlock = ^{
                NSLog(@"点击了收藏%zd",indexPath.row);
            };
            strongSelf.colonView.addShopCarBlock = ^{
                NSLog(@"点击了加入购物车%zd",indexPath.row);
            };
            strongSelf.colonView.sameBrandBlock = ^{
                NSLog(@"点击了同品牌%zd",indexPath.row);
            };
            strongSelf.colonView.samePriceBlock = ^{
                NSLog(@"点击了同价格%zd",indexPath.row);
            };
        };
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        PLCustionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLCustionHeadViewID forIndexPath:indexPath];
        __weak typeof(self)weakSelf = self;
        headerView.filtrateClickBlock = ^{//点击了筛选
            [weakSelf filtrateButtonClick];
        };
        reusableview = headerView;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (_isSwitchGrid) ? CGSizeMake(ScreenW, 120) : CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 60);//列表、网格Cell
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 40); //头部
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (_isSwitchGrid) ? 0 : 4;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了商品第%zd",indexPath.row);
    
    
    PLGoodDetailViewController *dcVc = [[PLGoodDetailViewController alloc] init];
    dcVc.goodTitle = _setItem[indexPath.row].main_title;
    dcVc.goodPrice = _setItem[indexPath.row].price;
    dcVc.goodSubTitle = _setItem[indexPath.row].goods_title;
    dcVc.shufflingArray = _setItem[indexPath.row].images;
    dcVc.goodImageView = _setItem[indexPath.row].image_url;
    
    [self.navigationController pushViewController:dcVc animated:YES];
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.colonView.pl_x = ScreenW;
    }completion:^(BOOL finished) {
        [weakSelf.colonView removeFromSuperview];
    }];
}
#pragma mark - 滑动代理
//开始滑动的时候记录位置
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    lastContentOffset = scrollView.contentOffset.y;
    
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    if(scrollView.contentOffset.y > lastContentOffset){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.collectionView.frame = CGRectMake(0, 20, ScreenW, ScreenH - 20);
        self.view.backgroundColor = [UIColor whiteColor];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.collectionView.frame = CGRectMake(0, PLTopNavH, ScreenW, ScreenH - PLTopNavH);
        self.view.backgroundColor = PLBGColor;
    }
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.footprintButton.pl_y = (strongSelf.backTopButton.hidden == YES) ? ScreenH - 60 : ScreenH - 110;
    }];
    
}

#pragma mark - 冒号工具View
- (void)setUpColonInsView:(UICollectionViewCell *)cell
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ //单列
        _colonView = [[PLColonInsView alloc] init];
        
    });
    [cell addSubview:_colonView];
    
    _colonView.frame = CGRectMake(cell.pl_width, 0, cell.pl_width - 120, cell.pl_height);
    
    [UIView animateWithDuration:0.5 animations:^{
        _colonView.pl_x = 120;
    }];
}
#pragma mark - 切换视图按钮点击
- (void)switchViewButtonBarItemBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    _isSwitchGrid = !_isSwitchGrid;
    
    [self.collectionView reloadData];
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
#pragma mark - 商品浏览足迹
- (void)footprintButtonClick
{
    [self setUpAlterViewControllerWith:[PLFootprintGoodsViewController alloc] WithDistance:ScreenW * 0.4];
}

#pragma mark - 商品筛选
- (void)filtrateButtonClick
{
    [self setUpAlterViewControllerWith:[PLFiltrateViewController alloc] WithDistance:ScreenW * 0.7];
}


#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance
{
    XWDrawerAnimatorDirection direction = XWDrawerAnimatorDirectionRight;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = YES;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

#pragma 退出界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
