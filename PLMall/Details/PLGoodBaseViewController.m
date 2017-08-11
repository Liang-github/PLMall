//
//  PLGoodBaseViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLGoodBaseViewController.h"

//Controllers
#import "PLFootprintGoodsViewController.h"
#import "PLShareToViewController.h"
#import "PLToolsViewController.h"
#import "PLFeatureSelectionViewController.h"
#import "PLFillinOrderViewController.h"
//Views
#import "PLLIRLButton.h"
#import "PLDetailShufflingHeadView.h" //头部轮播
#import "PLDetailGoodReferralCell.h" //商品标题价格介绍
#import "PLDetailShowTypeCell.h" //种类
#import "PLShowTypeOneCell.h"
#import "PLShowTypeTwoCell.h"
#import "PLShowTypeThreeCell.h"
#import "PLShowTypeFourCell.h"
#import "PLDetailServicetCell.h" //服务
#import "PLDetailLikeCell.h" //猜你喜欢
#import "PLDetailOverFooterView.h" //尾部结束
#import "PLDetailPartCommentCell.h" //部分评论
#import "PLDetailCustomHeadView.h" //自定义头部
//Vendors
#import "AddressPickerView.h"
#import <WebKit/WebKit.h>
#import <MJRefresh.h>
#import <MJExtension.h>
//Categories
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
@interface PLGoodBaseViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WKNavigationDelegate>

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WKWebView *webView;
//选择地址弹框
@property (nonatomic, strong) AddressPickerView *adPickerView;
//已选组Cell
@property (nonatomic, weak) PLShowTypeOneCell *cell;
//滚回顶部按钮
@property (nonatomic, strong) UIButton *backTopButton;
//通知
@property (nonatomic, weak) id dcObj;
@end

//header
static NSString *PLDetailShufflingHeadViewID = @"PLDetailShufflingHeadView";
static NSString *PLDetailCustomHeadViewID = @"PLDetailCustomHeadView";
//cell
static NSString *PLDetailGoodReferralCellID = @"PLDetailGoodReferralCell";

static NSString *PLShowTypeOneCellID = @"PLShowTypeOneCell";
static NSString *PLShowTypeTwoCellID = @"PLShowTypeTwoCell";
static NSString *PLShowTypeThreeCellID = @"PLShowTypeThreeCell";
static NSString *PLShowTypeFourCellID = @"PLShowTypeFourCell";

static NSString *PLDetailServicetCellID = @"PLDetailServicetCell";
static NSString *PLDetailLikeCellID = @"PLDetailLikeCell";
static NSString *PLDetailPartCommentCellID = @"PLDetailPartCommentCell";
//footer
static NSString *PLDetailOverFooterViewID = @"PLDetailOverFooterView";

static NSInteger lastNum;
static NSArray *lastSeleArray;
@implementation PLGoodBaseViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.contentSize = CGSizeMake(ScreenW, (ScreenH - 50)*2);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.scrollEnabled = NO;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.frame = CGRectMake(0, PLTopNavH, ScreenW, ScreenH - PLTopNavH - 50);
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.scrollerView addSubview:_collectionView];
        
        //注册header
        [_collectionView registerClass:[PLDetailShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLDetailShufflingHeadViewID];
        [_collectionView registerClass:[PLDetailCustomHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLDetailCustomHeadViewID];
        //注册Cell
        [_collectionView registerClass:[PLDetailGoodReferralCell class] forCellWithReuseIdentifier:PLDetailGoodReferralCellID];
        [_collectionView registerClass:[PLShowTypeOneCell class] forCellWithReuseIdentifier:PLShowTypeOneCellID];
        [_collectionView registerClass:[PLShowTypeTwoCell class] forCellWithReuseIdentifier:PLShowTypeTwoCellID];
        [_collectionView registerClass:[PLShowTypeThreeCell class] forCellWithReuseIdentifier:PLShowTypeThreeCellID];
        [_collectionView registerClass:[PLShowTypeFourCell class] forCellWithReuseIdentifier:PLShowTypeFourCellID];
        [_collectionView registerClass:[PLDetailLikeCell class] forCellWithReuseIdentifier:PLDetailLikeCellID];
        [_collectionView registerClass:[PLDetailPartCommentCell class] forCellWithReuseIdentifier:PLDetailPartCommentCellID];
        [_collectionView registerClass:[PLDetailServicetCell class] forCellWithReuseIdentifier:PLDetailServicetCellID];
        //注册Footer
        [_collectionView registerClass:[PLDetailOverFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLDetailOverFooterViewID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //间隔
    }
    return _collectionView;
}
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH - 50);
        _webView.scrollView.contentInset = UIEdgeInsetsMake(PLTopNavH, 0, 0, 0);
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        [self.scrollerView addSubview:_webView];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInit];
    [self setUpViewScroller];
    [self setUpGoodsWKWebView];
    [self setUpSuspendView];
    [self acceptanceNote];
}
#pragma mark - initialize
- (void)setUpInit {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = PLBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    //初始化
    lastSeleArray = [NSMutableArray array];
    lastNum = 0;
}
#pragma mark - 接收通知
- (void)acceptanceNote {
    //分享通知
    __weak typeof(self) weakSelf = self;
    _dcObj = [[NSNotificationCenter defaultCenter] addObserverForName:@"shareAlertView" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf selfAlertViewBack];
        [weakSelf setUpAlertViewControllerWith:[PLShareToViewController new] withDistance:300 withDirection:XWDrawerAnimatorDirectionBottom withParallaxEnable:NO withFlipEnable:NO];
    }];
    //加入购物车或点击直接购买通知
    _dcObj = [[NSNotificationCenter defaultCenter] addObserverForName:@"ClickAddOrBuy" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        PLFeatureSelectionViewController *plFeaVc = [PLFeatureSelectionViewController new];
        __weak typeof(self) weakSelf = self;
        plFeaVc.userChooseBlock = ^(NSMutableArray *seleArray, NSInteger num, NSInteger tag) {
            //第一次更新选择的属性
            NSString *result = [NSString stringWithFormat:@"%@ %zd件",[seleArray componentsJoinedByString:@"，"],num];
            weakSelf.cell.contentLabel.text = result;
        };
        
        if ([weakSelf.cell.leftTitleLabel.text isEqual:@"已选"]) {
            if ([note.userInfo[@"buttonTag"] isEqualToString:@"2"]) {
                //加入购物车
                
            } else if ([note.userInfo[@"buttonTag"] isEqualToString:@"3"]) {
                //立即购买
                PLFillinOrderViewController *plFillVc = [PLFillinOrderViewController new];
                [weakSelf.navigationController pushViewController:plFillVc animated:YES];
            }
        } else {
            plFeaVc.goodImageView = _goodImageView;
            [self setUpAlertViewControllerWith:plFeaVc withDistance:ScreenW*0.8 withDirection:XWDrawerAnimatorDirectionBottom withParallaxEnable:YES withFlipEnable:YES];
        }
    }];
}

#pragma mark - 悬浮按钮
- (void)setUpSuspendView {
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 100, 40, 40);
}

#pragma mark - 记载图文详情
- (void)setUpGoodsWKWebView {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weibo.com/u/5605532343"]];
    [self.webView loadRequest:request];
    //下拉返回商品详情View
    UIView *topHitView = [[UIView alloc] init];
    topHitView.frame = CGRectMake(0, -35, ScreenW, 35);
    PLLIRLButton *topHitButton = [PLLIRLButton buttonWithType:UIButtonTypeCustom];
    topHitButton.imageView.transform = CGAffineTransformRotate(topHitButton.imageView.transform, M_PI); //旋转
    [topHitButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:0];
    [topHitButton setTitle:@"下拉返回商品详情" forState:0];
    topHitButton.titleLabel.font = PFR12Font;
    [topHitButton setTitleColor:[UIColor lightGrayColor] forState:0];
    [topHitView addSubview:topHitButton];
    topHitButton.frame = topHitView.bounds;
    [self.webView.scrollView addSubview:topHitView];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 6;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (section == 0 || section == 2 || section == 3) ? 2 : 1;
}
#pragma mark - <UICollectionViewDelegate>
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridCell = nil;
    PLUserInfo *userInfo = UserInfoData;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PLDetailGoodReferralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLDetailGoodReferralCellID forIndexPath:indexPath];
            cell.goodTitleLabel.text = _goodTitle;
            cell.goodPriceLabel.text = [NSString stringWithFormat:@"￥%@",_goodPrice];
            cell.goodSubtitleLabel.text = _goodSubTitle;
            [PLSpeedy pl_setUpLabel:cell.goodTitleLabel content:_goodTitle indentationFortheFirstLineWith:cell.goodPriceLabel.font.pointSize*2];
            __weak typeof(self) weakSelf = self;
            cell.shareButtonClickBlock = ^{
                [weakSelf setUpAlertViewControllerWith:[PLShareToViewController new] withDistance:300 withDirection:XWDrawerAnimatorDirectionBottom withParallaxEnable:NO withFlipEnable:NO];
            };
            gridCell = cell;
        } else if (indexPath.row == 1) {
            PLShowTypeFourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLShowTypeFourCellID forIndexPath:indexPath];
            gridCell = cell;
        }
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        if (indexPath.section == 1) {
            PLShowTypeOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLShowTypeOneCellID forIndexPath:indexPath];
            _cell = cell;
            cell.leftTitleLabel.text = @"点击";
            cell.contentLabel.text = @"请选择该商品属性";
            gridCell = cell;
        } else {
            if (indexPath.row == 0) {
                PLShowTypeTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLShowTypeTwoCellID forIndexPath:indexPath];
                cell.contentLabel.text = userInfo.defaultAddress; //地址
                gridCell = cell;
            } else {
                PLShowTypeThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLShowTypeThreeCellID forIndexPath:indexPath];
                gridCell = cell;
            }
        }
    } else if (indexPath.section == 3) {
        PLDetailServicetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLDetailServicetCellID forIndexPath:indexPath];
        NSArray *btnTitles = @[@"以旧换新",@"可选增值服务"];
        NSArray *btnImages = @[@"detail_xiangqingye_yijiuhuanxin",@"ptgd_icon_zengzhifuwu"];
        NSArray *titles = @[@"以旧换新再送好礼",@"为商品保价护航"];
        [cell.serviceButton setTitle:btnTitles[indexPath.row] forState:0];
        [cell.serviceButton setImage:[UIImage imageNamed:btnImages[indexPath.row]] forState:0];
        cell.serviceLabel.text = titles[indexPath.row];
        if (indexPath.row == 0) {
            //分割线
            [PLSpeedy pl_setUpLongLineWith:cell withColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4] withHightRatio:0.6];
        }
        gridCell = cell;
    } else if (indexPath.section == 4) {
        PLDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLDetailPartCommentCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
        gridCell = cell;
    } else if (indexPath.section == 5) {
        PLDetailLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLDetailLikeCellID forIndexPath:indexPath];
        gridCell = cell;
    }
    return gridCell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            PLDetailShufflingHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLDetailShufflingHeadViewID forIndexPath:indexPath];
            headerView.shufflingArray = _shufflingArray;
            reusableView = headerView;
        } else if (indexPath.section == 5) {
            PLDetailCustomHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PLDetailCustomHeadViewID forIndexPath:indexPath];
            reusableView = headerView;
        }
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 5) {
            PLDetailOverFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PLDetailOverFooterViewID forIndexPath:indexPath];
            reusableView = footerView;
        } else {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
            footerView.backgroundColor = PLBGColor;
            reusableView = footerView;
        }
    }
    return reusableView;
}
#pragma mark - item宽度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //商品详情
        return (indexPath.section == 0) ? CGSizeMake(ScreenW, [PLSpeedy pl_calculateTextSizeWithText:_goodTitle withTextFont:16 withMaxW:ScreenW - PLMargin*6].height + [PLSpeedy pl_calculateTextSizeWithText:_goodPrice withTextFont:20 withMaxW:ScreenW - PLMargin*6].height + [PLSpeedy pl_calculateTextSizeWithText:_goodSubTitle withTextFont:12 withMaxW:ScreenW - PLMargin*6].height + PLMargin*4) : CGSizeMake(ScreenW, 35);
    } else if (indexPath.section == 1) {
        //商品属性选择
        return CGSizeMake(ScreenW, 60);
    } else if (indexPath.section == 2) {
        //商品快递信息
        return CGSizeMake(ScreenW, 60);
    } else if (indexPath.section == 3) {
        //商品保价
        return CGSizeMake(ScreenW/2, 60);
    } else if (indexPath.section == 4) {
        //商品评价部分展示
        return CGSizeMake(ScreenW, 270);
    } else if (indexPath.section == 5) {
        //商品猜你喜欢
        return CGSizeMake(ScreenW, (ScreenW/3 + 60)*2 + 20);
    } else {
        return CGSizeZero;
    }
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ? CGSizeMake(ScreenW, ScreenH*0.55) : (section == 5) ? CGSizeMake(ScreenW, 30) : CGSizeZero;
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return (section == 5) ? CGSizeMake(ScreenW, 35) :CGSizeMake(ScreenW, PLMargin);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self scrollToDetailsPage]; //滚动到详情页面
        
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        [self changeUserAddress]; //更换地址
    } else if (indexPath.section == 1) {
        //属性选择
        PLFeatureSelectionViewController *plFeaVc = [PLFeatureSelectionViewController new];
        __weak typeof(self) weakSelf = self;
        
        plFeaVc.userChooseBlock = ^(NSMutableArray *seleArray, NSInteger num, NSInteger tag) {
            //更新选择的属性
            if (lastSeleArray == seleArray && lastNum == num) {
                return; //
            }
            NSString *result = [NSString stringWithFormat:@"%@ %zd件",[seleArray componentsJoinedByString:@"，"],num];
            weakSelf.cell.contentLabel.text = result;
            lastNum = num;
            lastSeleArray = seleArray;
            if (tag == 0) {
                
            } else if (tag == 1) {
                PLFillinOrderViewController *plFillVc = [PLFillinOrderViewController new];
                [weakSelf.navigationController pushViewController:plFillVc animated:YES];
            }
            if ([weakSelf.cell.leftTitleLabel.text isEqualToString:@"已选"]) {
                return;
            }
            weakSelf.cell.leftTitleLabel.text = @"已选";
        };
        plFeaVc.lastNum = lastNum;
        plFeaVc.lastSeleArray = lastSeleArray;
        plFeaVc.goodImageView = _goodImageView;
        [self setUpAlertViewControllerWith:plFeaVc withDistance:ScreenH*0.8 withDirection:XWDrawerAnimatorDirectionBottom withParallaxEnable:YES withFlipEnable:YES];
    }
}
#pragma mark - 视图滚动
- (void)setUpViewScroller {
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(YES);
            weakSelf.scrollerView.contentOffset = CGPointMake(0, ScreenH);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }];
    
    self.webView.scrollView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.8 animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(NO);
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.webView.scrollView.mj_header endRefreshing];
        }];
    }];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;
}
#pragma mark - 点击事件
#pragma mark - 更换地址
- (void)changeUserAddress {
    _adPickerView = [AddressPickerView shareInstance];
    [_adPickerView showAddressPickView];
    [self.view addSubview:_adPickerView];
    
    __weak typeof(self) weakSelf = self;
    _adPickerView.block = ^(NSString *province, NSString *city, NSString *district) {
        PLUserInfo *userInfo = UserInfoData;
        NSString *newAddress = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
        if ([userInfo.defaultAddress isEqualToString:newAddress]) {
            return;
        }
        userInfo.defaultAddress = newAddress;
        [userInfo save];
        [weakSelf.collectionView reloadData];
    };
}
#pragma mark - 滚动到详情页面
- (void)scrollToDetailsPage {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToDetailsPage" object:nil];
    });
}
#pragma mark - collectionView滚回顶部
- (void)scrollToTop {
    if (self.scrollerView.contentOffset.y > ScreenH) {
        [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    } else {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }];
    }
    !_changeTitleBlock ? : _changeTitleBlock(NO);
}
#pragma mark - 转场动画弹出控制器
- (void)setUpAlertViewControllerWith:(UIViewController *)vc withDistance:(CGFloat)distance withDirection:(XWDrawerAnimatorDirection)vcDirection withParallaxEnable:(BOOL)parallaxEnable withFlipEnable:(BOOL)flipEnable {
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self) weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlertViewBack];
    }];
}
#pragma mark - 退出界面
- (void)selfAlertViewBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_dcObj];
}
@end
