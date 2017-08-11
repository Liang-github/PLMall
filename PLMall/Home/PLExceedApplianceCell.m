//
//  PLExceedApplianceCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLExceedApplianceCell.h"
#import "PLGoodsHandheldCell.h"
#import <UIImageView+WebCache.h>

@interface PLExceedApplianceCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
//头部ImageView
@property (nonatomic, strong) UIImageView *headImageView;
//图片数组
@property (nonatomic, strong) NSArray *imagesArray;
@end
static NSString *const PLGoodsHandheldCellID = @"PLGoodsHandHeldCell";
@implementation PLExceedApplianceCell
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        
        _collectionView.frame = CGRectMake(0, ScreenW*0.35 + PLMargin, ScreenW, 100);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[PLGoodsHandheldCell class] forCellWithReuseIdentifier:PLGoodsHandheldCellID];
    }
    return _collectionView;
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
    
    _headImageView = [[UIImageView alloc] init];
    [self addSubview:_headImageView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(ScreenW*0.35);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesArray.count - 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLGoodsHandheldCellID forIndexPath:indexPath];
    cell.handheldImage = _imagesArray[indexPath.row + 1];
    return cell;
}
- (void)setGoodExceedArray:(NSArray *)goodExceedArray {
    _goodExceedArray = goodExceedArray;
    _imagesArray = goodExceedArray;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
}
@end
