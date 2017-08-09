//
//  PLDetailPartCommentCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailPartCommentCell.h"
#import "PLCommentHeaderCell.h"
#import "PLCommentFooterCell.h"
#import "PLCommentContentCell.h"

@interface PLDetailPartCommentCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
@end

static NSString *const PLCommentHeaderCellID = @"PLCommentHeaderCell";
static NSString *const PLCommentFooterCellID = @"PLCommentFooterCell";
static NSString *const PLCommentContentCellID = @"PLCommentContentCell";

@implementation PLDetailPartCommentCell
#pragma mark - LoadLazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //注册
        [_collectionView registerClass:[PLCommentHeaderCell class] forCellWithReuseIdentifier:PLCommentHeaderCellID];
        [_collectionView registerClass:[PLCommentFooterCell class] forCellWithReuseIdentifier:PLCommentFooterCellID];
        [_collectionView registerClass:[ PLCommentContentCell class] forCellWithReuseIdentifier:PLCommentContentCellID];
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
    self.collectionView.backgroundColor = self.backgroundColor;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (section == 0 || section == 1) ? 1 : 2;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) { //头部
        PLCommentHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLCommentHeaderCellID forIndexPath:indexPath];
        cell.comNum = @"668";
        cell.wellPer = @"100%";
        gridcell = cell;
    } else if (indexPath.section == 1) { //中间
        PLCommentContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLCommentContentCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
        gridcell = cell;
    } else if (indexPath.section == 2) { //底部
        PLCommentFooterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLCommentFooterCellID forIndexPath:indexPath];
        NSArray *images = @[@"JX_pinglun1_liebiao",@"ptgd_icon_zixun"];
        NSArray *titles = @[@"全部评论（188）",@"购买咨询（22）"];
        [cell.commentFootButton setImage:[UIImage imageNamed:images[indexPath.row]] forState:UIControlStateNormal];
        [cell.commentFootButton setTitle:titles[indexPath.row] forState:UIControlStateNormal];
        cell.isShowLine = (indexPath.row == 0) ? YES : NO; //分割线
        gridcell = cell;
    }
    return gridcell;
}

#pragma mark - <UICollectionViewDelegate>
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0) ? CGSizeMake(ScreenW, 30) : (indexPath.section == 2) ? CGSizeMake(ScreenW/2, 40) : CGSizeMake(ScreenW, 200);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToCommentsPage" object:nil];
    });
}
@end
