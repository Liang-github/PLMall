//
//  PLPersonalCenterViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//
#define PLHeadImageTopY 180

#import "PLPersonalCenterViewController.h"

#import "PLSettingViewController.h"
#import "PLMessageViewController.h"
#import "PLGoodsSetViewController.h"
#import "PLMyselfMessageViewController.h"

#import "PLFlowItem.h"
#import "PLRecomendItem.h"

#import "PLHoverNavView.h"
#import "PLMySelfHeadView.h"
#import "PLFlowAttributeCell.h"
#import "PLGoodsYouLikeCell.h"
#import "PLOverFootView.h"
#import "PLYouLikeHeadView.h"

#import <MJExtension.h>

#import "UIBarButtonItem+PLBarButtonItem.h"

@interface PLPersonalCenterViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *backTopButton;
@property (nonatomic, strong) NSMutableArray <PLFlowItem *> *buyFlowItem;
@property (nonatomic, strong) NSMutableArray <PLFlowItem *> *recreationFlowItem;
@property (nonatomic, strong) NSMutableArray <PLRecomendItem *> * youLikeItem;
@property (nonatomic, strong) PLHoverNavView *hoverNavView;

@end
static NSInteger offsetY_;
static NSString *const PLMySelfHeadViewID = @"PLMySelfHeadView";
static NSString *const PLFlowAttributeCellID = @"PLFlowAttributeCell";
static NSString *const PLGoodsYouLikeCellID = @"PLGoodsYouLikeCellID";
static NSString *const PLOverFootViewID = @"PLOverFootView";
static NSString *const PLYouLikeHeadViewID = @"PLYouLikeHeadView";
@implementation PLPersonalCenterViewController
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.frame = CGRectMake(0, -PLHeadImageTopY, ScreenW, ScreenH - PLBottomTabH + PLHeadImageTopY);
        //头部
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PLMySelfHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLMySelfHeadViewID];
        [_collectionView registerClass:[PLYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLYouLikeHeadViewID];
        //尾部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];//分割线
        [_collectionView registerClass:[PLOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLOverFootViewID];
        //cell
        [_collectionView registerClass:[PLFlowAttributeCell class] forCellWithReuseIdentifier:PLFlowAttributeCellID];
        [_collectionView registerClass:[PLGoodsYouLikeCell class] forCellWithReuseIdentifier:PLGoodsYouLikeCellID];
    }
    return _collectionView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpNav];
    [self setUpData];
    [self setUpScrollToTopView];
}
- (void)setUpBase {
    self.view.backgroundColor = PLBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)setUpData {
    _buyFlowItem = [PLFlowItem mj_objectArrayWithFilename:@"MyBuyFlow.plist"];
    _recreationFlowItem = [PLFlowItem mj_objectArrayWithFilename:@"MyRecreationFlow.plist"];
    _youLikeItem = [PLRecomendItem mj_objectArrayWithFilename:@"YouLikeGoods.plist"];
}
- (void)setUpScrollToTopView {
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 110, 40, 40);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (section == 0 || section == 1) ? 5 : (section == 2) ? 8 : 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridCell = nil;
    if (indexPath.section == 3) {
        //猜你喜欢
        PLGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsYouLikeCellID forIndexPath:indexPath];
        cell.youLikeItem = _youLikeItem[indexPath.row];
        cell.sameButton.hidden = YES;
        gridCell = cell;
    } else {
        //属性
        PLFlowAttributeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLFlowAttributeCellID forIndexPath:indexPath];
        NSArray *titles = @[@"账户余额",@"优惠券",@"美豆",@"美通卡",@"我的金融"];
        cell.backgroundColor = (indexPath.row == titles.count - 1 && indexPath.section != 2) ? RGB(249, 249, 249) : [UIColor whiteColor];
        if (indexPath.section == 0) {
            cell.type = PLFlowTypeImage;
            cell.flowItem = _buyFlowItem[indexPath.row];
        } else if (indexPath.section == 1) {
            cell.type = PLFlowTypeLabel;
            if (indexPath.row == titles.count - 1) {
                cell.lastIsImageView = YES;
                cell.flowImageView.image = [UIImage imageNamed:@"wodejingrong"];
                
            } else {
                cell.lastIsImageView = NO;
                cell.flowNumLabel.text = @"0";
            }
            cell.flowTextLabel.text = titles[indexPath.row];
        } else {
            cell.type = PLFlowTypeImage;
            cell.flowItem = _recreationFlowItem[indexPath.row];
        }
        gridCell = cell;
    }
    return gridCell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            PLMySelfHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLMySelfHeadViewID forIndexPath:indexPath];
            __weak typeof(self) weakSelf = self;
            PLUserInfo *userInfo = UserInfoData;
            UIImage *image = ([userInfo.userimage isEqualToString:@"icon"]) ? [UIImage imageNamed:@"icon"] : [PLSpeedy base64StrToImage:userInfo.userimage];
            headerView.nicknameLabel.text = userInfo.nickname;
            [headerView.headImageButton setImage:image forState:UIControlStateNormal];
            headerView.goodsCollectionClickBlock = ^{
                NSLog(@"点击了商品收藏");
            };
            headerView.shopCollectionClickBlock = ^{
                NSLog(@"点击了店铺收藏");
            };
            headerView.myFootprintClickBlock = ^{
                NSLog(@"点击了我的足迹");
            };
            headerView.mySideClickBlock = ^{
                NSLog(@"点击了身边");
            };
            headerView.myHeadImageViewClickBlock = ^{
                NSLog(@"点击了头像");
                PLMyselfMessageViewController *selfVc = [[PLMyselfMessageViewController alloc] init];
                [weakSelf.navigationController pushViewController:selfVc animated:YES];
            };
            reusableView = headerView;
        } else if (indexPath.section == 3) {
            PLYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLYouLikeHeadViewID forIndexPath:indexPath];
            [headerView.likeButton setTitle:@"热门推荐" forState:0];
            [headerView.likeButton setTitleColor:RGB(14, 122, 241) forState:UIControlStateNormal];
            [headerView.likeButton setImage:[UIImage imageNamed:@"shouye_icon02"] forState:0];
            reusableView = headerView;
        }
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
            UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
            footView.backgroundColor = PLBGColor;
            reusableView = footView;
        } else if (indexPath.section == 3) {
            PLOverFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLOverFootViewID forIndexPath:indexPath];
            reusableView = footView;
        }
    }
    return reusableView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        //属性
        return CGSizeMake(ScreenW/5, 80);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(ScreenW/4, 80);
    }
    if (indexPath.section == 3) {
        return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 40);
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ? CGSizeMake(ScreenW, 400) : (section == 3) ? CGSizeMake(ScreenW, 40) : CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return (section == 3) ? CGSizeMake(ScreenW, 40) : CGSizeMake(ScreenW, PLMargin);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 3) ? 4 : 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 3) ? 4 : 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了10个第%zd属性的%zd",indexPath.section,indexPath.row);
    if (indexPath.section == 3) {
        PLGoodsSetViewController *goodSetVc = [[PLGoodsSetViewController alloc] init];
        goodSetVc.goodPlistName = @"ClasiftyGoods.plist";
        [self.navigationController pushViewController:goodSetVc animated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    offsetY_ = scrollView.contentOffset.y;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (scrollView.contentOffset.y < offsetY_) {
            weakSelf.hoverNavView.pl_y = PLHeadImageTopY - 70;
        }
    } completion:^(BOOL finished) {
        weakSelf.hoverNavView.pl_y = -100;
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.hoverNavView.pl_y = PLHeadImageTopY;
        }];
    }];
}
#pragma mark - collectionView滚回顶部
- (void)scrollToTop {
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
- (void)setUpNav {
    _hoverNavView = [[PLHoverNavView alloc] init];
    [self.collectionView insertSubview:_hoverNavView atIndex:0];
    _hoverNavView.frame = CGRectMake(0, PLHeadImageTopY, ScreenW, 64);
    __weak typeof(self) weakSelf = self;
    _hoverNavView.leftItemClickBlock = ^{
        [weakSelf settingItemClick];
    };
    _hoverNavView.rightItemCickBlock = ^{
        [weakSelf messageItemClick];
    };
}
- (void)settingItemClick {
    PLSettingViewController *settingVC = [[PLSettingViewController alloc] init];
    settingVC.title = @"设置";
    [self.navigationController pushViewController:settingVC animated:YES];
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
