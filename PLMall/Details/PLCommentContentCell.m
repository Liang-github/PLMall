//
//  PLCommentContentCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLCommentContentCell.h"
#import "PLCommentPicItem.h"
#import "PLCommentPicCell.h"
#import "PLPartCommentHeadView.h"
#import <MJExtension.h>

@interface PLCommentContentCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) PLPartCommentHeadView *headView;
//图片数组
@property (nonatomic, strong) NSMutableArray<PLCommentPicItem *> *picItem;
@end
static NSString *const PLCommentPicCellID = @"PLCommentPicCell";
@implementation PLCommentContentCell

#pragma mark - LoadLazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //注册
        [_collectionView registerClass:[PLCommentContentCell class] forCellWithReuseIdentifier:PLCommentPicCellID];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    _picItem = [PLCommentPicItem mj_objectArrayWithFilename:@"CommentPic.plist"];
    [self setUpCommentCell];
}
- (void)setUpCommentCell {
    _headView = [[PLPartCommentHeadView alloc] init];
    _headView.picNum = @"12";
    [self addSubview:_headView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@100);
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(100);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(@100);
    }];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _picItem.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLCommentPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLCommentPicCellID forIndexPath:indexPath];
    cell.picItem = _picItem[indexPath.row];
    return cell;
}
#pragma mark - <UICollectionViewDelegate>
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}
@end
