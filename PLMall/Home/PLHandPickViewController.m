//
//  PLHandPickViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLHandPickViewController.h"

//Controllers
#import "BaseNavigationController.h"
#import "PLMessageViewController.h"
#import "PLGoodsSetViewController.h"
//Models
#import "PLGridItem.h"
#import "PLRecomendItem.h"
//Views
#import "PLNavSearchBarView.h"
//cell
#import "PLGoodsCountDownCell.h" //倒计时商品
#import "PLGoodsHandheldCell.h" //掌上专享
#import "PLExceedApplianceCell.h" //不止
#import "PLGoodsYouLikeCell.h" //猜你喜欢商品
#import "PLGoodsGridCell.h" //10个选项
//head
#import "PLSlideshowHeadView.h" //轮播图
#import "PLCountDownHeadView.h" //倒计时标语
#import "PLYouLikeHeadView.h" //猜你喜欢等头部标语
//foot
#import "PLTopLineFootView.h" //热点
#import "PLOverFootView.h" //结束
#import "PLScrollAdFootView.h" //底滚动广告
//Vendors
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "SubLBXScanViewController.h"

//Categories
#import "UIBarButtonItem+PLBarButtonItem.h"

@interface PLHandPickViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<PLGridItem *> *gridItem;
@property (nonatomic, strong) NSMutableArray<PLRecomendItem *> *youLikeItem;
@property (nonatomic, strong) UIButton *backTopButton;

@end

//cell
static NSString *const PLGoodsCountDownCellID = @"PLGoodsCountDownCell";
static NSString *const PLGoodsHandheldCellID = @"PLGoodsHandheldCell";
static NSString *const PLGoodsYouLikeCellID = @"PLGoodsYouLikeCell";
static NSString *const PLGoodsGridCellID = @"PLGoodsGridCell";
static NSString *const PLExceedApplianceCellID = @"PLExceedApplianceCell";
//head
static NSString *const PLSlideshowHeadViewID = @"PLSlideshowHeadView";
static NSString *const PLCountDownHeadViewID = @"PLCountDownHeadView";
static NSString *const PLYouLikeHeadViewID = @"PLYouLikeHeadView";
//foot
static NSString *const PLTopLineFootViewID = @"PLTopLineFootView";
static NSString *const PLOverFootViewID = @"PLOverFootView";
static NSString *const PLScrollAdFootViewID = @"PLScrollAdFootView";
@implementation PLHandPickViewController
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.frame = CGRectMake(0, PLTopNavH, ScreenW, ScreenH - PLTopNavH - PLBottomTabH);
        _collectionView.showsVerticalScrollIndicator = NO;
        //注册
        [_collectionView registerClass:[PLGoodsCountDownCell class] forCellWithReuseIdentifier:PLGoodsCountDownCellID];
        [_collectionView registerClass:[PLGoodsHandheldCell class] forCellWithReuseIdentifier:PLGoodsHandheldCellID];
        [_collectionView registerClass:[PLGoodsYouLikeCell class] forCellWithReuseIdentifier:PLGoodsYouLikeCellID];
        [_collectionView registerClass:[PLGoodsGridCell class] forCellWithReuseIdentifier:PLGoodsGridCellID];
        [_collectionView registerClass:[PLExceedApplianceCell class] forCellWithReuseIdentifier:PLExceedApplianceCellID];
        
        [_collectionView registerClass:[PLTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLTopLineFootViewID];
        [_collectionView registerClass:[PLOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLOverFootViewID];
        [_collectionView registerClass:[PLScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLScrollAdFootViewID];
        
        [_collectionView registerClass:[PLYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLYouLikeHeadViewID];
        [_collectionView registerClass:[PLSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLSlideshowHeadViewID];
        [_collectionView registerClass:[PLCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLCountDownHeadViewID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.barTintColor == RGB(231, 23, 37)) {
        return;
    }
    self.navigationController.navigationBar.barTintColor = RGB(231, 23, 37);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpNav];
    [self setUpGoodsData];
    [self setUpScrollToTopView];
}
- (void)setUpBase {
    self.view.backgroundColor = PLBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)setUpGoodsData {
    _gridItem = [PLGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _youLikeItem = [PLRecomendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}
- (void)setUpScrollToTopView {
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:0];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 110, 40, 40);
}
- (void)setUpNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"richScan"] withHighlighted:[UIImage imageNamed:@"richScan"] target:self action:@selector(richScanItemClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"message"] withHighlighted:[UIImage imageNamed:@"message"] target:self action:@selector(messageItemClick)];
    
    PLNavSearchBarView *searchBarVc = [[PLNavSearchBarView alloc] init];
    searchBarVc.placeholdLabel.text = @"618 100元红包等你来抢";
    searchBarVc.frame = CGRectMake(60, 25, ScreenW - 120, 35);
    searchBarVc.voiceButtonClickBlock = ^{
        NSLog(@"语音点击回调");
    };
    searchBarVc.searchViewBlock = ^{
        NSLog(@"搜索");
    };
    self.navigationItem.titleView = searchBarVc;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _gridItem.count;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return GoodsHandheldImagesArray.count;
    }
    if (section == 4) {
        return _youLikeItem.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//10
        PLGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }
    else if (indexPath.section == 1) {//倒计时
        PLGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsCountDownCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//掌上专享
        PLExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLExceedApplianceCellID forIndexPath:indexPath];
        cell.goodExceedArray = GoodsRecommendArray;
        gridcell = cell;
        
    }
    else if (indexPath.section == 3) {//推荐
        PLGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsHandheldCellID forIndexPath:indexPath];
        NSArray *images = GoodsHandheldImagesArray;
        cell.handheldImage = images[indexPath.row];
        gridcell = cell;
    }
    else {//猜你喜欢
        PLGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsYouLikeCellID forIndexPath:indexPath];
        cell.lookSameBlock = ^{
            NSLog(@"点击了第%zd商品的找相似",indexPath.row);
        };
        cell.youLikeItem = _youLikeItem[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            PLSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLSlideshowHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }else if (indexPath.section == 1){
            PLCountDownHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLCountDownHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }else if (indexPath.section == 3){
            PLYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLYouLikeHeadViewID forIndexPath:indexPath];
            [headerView.likeButton setTitle:@"品牌精选" forState:UIControlStateNormal];
            [headerView.likeButton setTitleColor:RGB(77, 171, 21) forState:UIControlStateNormal];
            [headerView.likeButton setImage:[UIImage imageNamed:@"shouye_icon03"] forState:UIControlStateNormal];
            reusableview = headerView;
        }else if (indexPath.section == 4){
            PLYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLYouLikeHeadViewID forIndexPath:indexPath];
            [headerView.likeButton setTitle:@"热门推荐" forState:UIControlStateNormal];
            [headerView.likeButton setTitleColor:RGB(14, 122, 241) forState:UIControlStateNormal];
            [headerView.likeButton setImage:[UIImage imageNamed:@"shouye_icon02"] forState:UIControlStateNormal];
            reusableview = headerView;
        }
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            PLTopLineFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLTopLineFootViewID forIndexPath:indexPath];
            reusableview = footview;
        }else if (indexPath.section == 2){
            PLScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLScrollAdFootViewID forIndexPath:indexPath];
            reusableview = footerView;
        }else if (indexPath.section == 4) {
            PLOverFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLOverFootViewID forIndexPath:indexPath];
            reusableview = footview;
        }
    }
    
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//9宫格组
        return CGSizeMake(ScreenW/5 , ScreenW/5 + PLMargin);
    }
    if (indexPath.section == 1) {//计时
        return CGSizeMake(ScreenW, 150);
    }
    if (indexPath.section == 2) {//掌上
        return CGSizeMake(ScreenW,ScreenW * 0.35 + 120);
    }
    if (indexPath.section == 3) {//推荐组
        return [self layoutAttributesForItemAtIndexPath:indexPath].size;
    }
    if (indexPath.section == 4) {//猜你喜欢
        return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 40);
    }
    return CGSizeZero;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.35);
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.2);
        }else{
            layoutAttributes.size = CGSizeMake(ScreenW * 0.25, ScreenW * 0.35);
        }
    }
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(ScreenW, 150); //图片滚动的宽高
    }
    if (section == 1 ||section == 3 || section == 4) {//猜你喜欢的宽高
        return CGSizeMake(ScreenW, 40);  //推荐适合的宽高
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenW, 60);  //Top头条的宽高
    }
    if (section == 2) {
        return CGSizeMake(ScreenW, 80); // 滚动广告
    }
    if (section == 4) {
        return CGSizeMake(ScreenW, 40); // 结束
    }
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 4) ? 4 : 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 4) ? 4 : 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"点击了10个属性第%zd",indexPath.row);
    } else if (indexPath.section == 4) {
        NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
        PLGoodsSetViewController *goodSetVc = [[PLGoodsSetViewController alloc] init];
        goodSetVc.goodPlistName = @"ClasiftyGoods.plist";
        [self.navigationController pushViewController:goodSetVc animated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;
}
- (void)scrollToTop {
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
#pragma mark - 二维码扫码
- (void)richScanItemClick {
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc] init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    SubLBXScanViewController *vc = [[SubLBXScanViewController alloc] init];
    vc.title = @"扫一扫";
    vc.style = style;
    vc.isQQSimulator = YES;
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    vc.scanResult = ^(NSString *strScanned) {
        NSLog(@"扫码结果");
    };
}
- (void)messageItemClick {
    PLMessageViewController *messageVc = [[PLMessageViewController alloc] init];
    messageVc.title = @"消息中心";
    [self.navigationController pushViewController:messageVc animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
