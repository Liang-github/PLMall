//
//  PLDetailLikeCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailLikeCell.h"
#import "PLRecomendItem.h"
#import "PLDetailLikeItemCell.h"
#import <MJExtension.h>

@interface PLDetailLikeCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//collection
@property (nonatomic, strong) UICollectionView *collectionView;
//推荐商品数据
@property (nonatomic, strong) NSMutableArray<PLRecomendItem *> *detailRecItem;
//页面
@property (nonatomic, strong) UIPageControl *pageControl;
@end
static NSString *const PLDetailLikeItemCellID = @"PLDetailLikeItemCell";

@implementation PLDetailLikeCell
#pragma mark - Lazyload
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(self.pl_width/3, self.pl_width/3 + 60);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = CGRectMake(0, 0, self.pl_width, self.pl_height - 20);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        
        [_collectionView registerClass:[PLDetailLikeItemCell class] forCellWithReuseIdentifier:PLDetailLikeItemCellID];
    }
    return _collectionView;
}

@end
