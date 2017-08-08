//
//  PLMyTrolleyViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//
#define collectionViewW 100
#define collectionViewH 150
#define recommendReuseableViewH 40

#import "PLMyTrolleyViewController.h"
#import "PLRecomendItem.h"
#import "PLEmptyCartView.h"
#import "PLRecommendCell.h"
#import "PLRecommendReusableView.h"
#import <MJExtension.h>
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface PLMyTrolleyViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
//推荐商品数据
@property (nonatomic, strong) NSMutableArray<PLRecomendItem *> *recommendItem;

@end
static NSString *const PLRecommendCellID = @"PLRcommendCell";

@implementation PLMyTrolleyViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(collectionViewW, collectionViewH);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
        
        //注册cell
        [_collectionView registerClass:[PLRecommendCell class] forCellWithReuseIdentifier:PLRecommendCellID];
    }
    return _collectionView;
}
- (NSMutableArray<PLRecomendItem *> *)recommendItem {
    if (!_recommendItem) {
        _recommendItem = [NSMutableArray array];
    }
    return _recommendItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpRecommendData];
    [self setUpEmptyCartView];
    [self setUpRecommendReusableView];
}
#pragma mark - initizlize
- (void)setUpBase {
    self.view.backgroundColor = PLBGColor;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat colBottom = (self.isTabBar == NO) ? PLBottomTabH : 0;
    self.collectionView.frame = CGRectMake(0, ScreenH - collectionViewH - colBottom, ScreenW, collectionViewH);
}
#pragma mark - 推荐商品数据
- (void)setUpRecommendData {
    _recommendItem = [PLRecomendItem mj_objectArrayWithFilename:@"RecommendShop.plist"];
    
}
#pragma mark - 推荐提示View
- (void)setUpRecommendReusableView {
    PLRecommendReusableView *recommendReusableView = [[PLRecommendReusableView alloc] init];
    recommendReusableView.backgroundColor = self.collectionView.backgroundColor;
    [self.view addSubview:recommendReusableView];
    recommendReusableView.frame = CGRectMake(0, _collectionView.pl_y - recommendReuseableViewH, ScreenW, recommendReuseableViewH);
}
#pragma mark - 初始化空购物车View
- (void)setUpEmptyCartView {
    PLEmptyCartView *emptyCartView = [[PLEmptyCartView alloc] init];
    [self.view addSubview:emptyCartView];
    
    emptyCartView.frame = CGRectMake(0, PLTopNavH, ScreenW, ScreenH - PLTopNavH - PLBottomTabH - (collectionViewH + recommendReuseableViewH));
    emptyCartView.buyingClickBlock = ^{
        NSLog(@"点击了立即抢购");
    };
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _recommendItem.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLRecommendCellID forIndexPath:indexPath];
    cell.recommendItem = _recommendItem[indexPath.row];
    
    return cell;
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了推荐商品");
}

@end
