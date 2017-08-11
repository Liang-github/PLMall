//
//  PLGoodsCountDownCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLGoodsCountDownCell.h"
#import "PLRecomendItem.h"
#import "PLGoodsSurplusCell.h"
#import <MJExtension.h>

@interface PLGoodsCountDownCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<PLRecomendItem *> *countDownItem;
@property (nonatomic, strong) UIView *bottomLineView;
@end
static NSString *const PLGoodsSurplusCellID = @"PLGoodsSurplusCell";
@implementation PLGoodsCountDownCell
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(self.pl_height*0.65, self.pl_height*0.9);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[PLGoodsSurplusCell class] forCellWithReuseIdentifier:PLGoodsSurplusCellID];
    }
    return _collectionView;
}
- (NSMutableArray<PLRecomendItem *> *)countDownItem {
    if (!_countDownItem) {
        _countDownItem = [NSMutableArray array];
    }
    return _countDownItem;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    NSArray *countDownArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"CountDownShop.plist" ofType:nil]];
    _countDownItem = [PLRecomendItem mj_objectArrayWithKeyValuesArray:countDownArray];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = PLBGColor;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.pl_height - 8, ScreenW, 8);
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _countDownItem.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLGoodsSurplusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsSurplusCellID forIndexPath:indexPath];
    cell.recommendItem = _countDownItem[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了计时商品%zd",indexPath.row);
}
@end
