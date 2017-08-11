//
//  PLShareToViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLShareToViewController.h"
#import "PLShareItem.h"
#import "PLShareItemCell.h"
#import <MJExtension.h>
#import "UIViewController+XWTransition.h"
@interface PLShareToViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
//分享
@property (nonatomic, strong) NSMutableArray<PLShareItem *> *shareItem;

@end
static NSString *const PLShareItemCellID = @"PLShareItemCelll";

@implementation PLShareToViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //注册
        [_collectionView registerClass:[PLShareItemCell class] forCellWithReuseIdentifier:PLShareItemCellID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpShareAlertView];
    [self setUpBase];
    [self setUpTopBottomView];
}
- (void)setUpBase {
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _shareItem = [PLShareItem mj_objectArrayWithFilename:@"shareTerrace.plist"];
}
- (void)setUpTopBottomView {
    UILabel *shareLabel = [UILabel new];
    shareLabel.text = @"分享到";
    shareLabel.font = PFR18Font;
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.frame = CGRectMake(0, PLMargin, ScreenW, 35);
    [self.view addSubview:shareLabel];
    
    UIView *line = [UIView new];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    line.frame = CGRectMake(PLMargin, shareLabel.pl_bottom + PLMargin, ScreenW, 160);
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:0];
    cancelButton.adjustsImageWhenHighlighted  = NO;
    [cancelButton setTitleColor:[UIColor blackColor] forState:0];
    cancelButton.frame = CGRectMake(PLMargin, self.collectionView.pl_bottom + PLMargin*2, ScreenW - 2*PLMargin, 35);
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _shareItem.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLShareItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLShareItemCellID forIndexPath:indexPath];
    cell.shareItem = _shareItem[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第%zd分享平台",indexPath.row);
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 弹出弹框
- (void)setUpShareAlertView {
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    __weak typeof(self) weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } edgeSpacing:0];
}
#pragma mark - 取消点击
- (void)cancelButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.pl_width/4, 80);
}

@end
