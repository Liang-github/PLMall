//
//  PLHelpBackViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLHelpBackViewController.h"
#import "PLLIRLButton.h"
#import "PLHelpBackSquareCell.h"
#import "UIBarButtonItem+PLBarButtonItem.h"

static NSInteger const cols = 3;
static CGFloat const margin = 1;
#define itemHW (ScreenW - (cols - 1)*margin)/cols

@interface PLHelpBackViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@end
static NSString *const PLHelpBackSquareCellID = @"PLHelpBackSquareCell";

@implementation PLHelpBackViewController
#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置尺寸
        layout.itemSize = CGSizeMake(itemHW, itemHW);
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = margin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(0, 64, ScreenW, ScreenH - PLTopNavH - 44);
        [self.view addSubview:_collectionView];
        
        [_collectionView registerClass:[PLHelpBackSquareCell class] forCellWithReuseIdentifier:PLHelpBackSquareCellID];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpColl];
    [self setUpNav];
    [self setUpBottomView];
}
#pragma mark - initialize
- (void)setUpColl {
    self.view.backgroundColor = PLBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark - Nav设置
- (void)setUpNav {
    self.title = @"帮助与反馈";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"反馈" style:UIBarButtonItemStyleDone target:self action:@selector(feedbackItemClick)];
}
#pragma mark - 底部
- (void)setUpBottomView {
    NSArray *titles = @[@"DC电话",@"在线客服"];
    NSArray *images = @[@"BZFK_newdianhua",@"ZXKF_kefu_helpback"];
    CGFloat btnH = 44;
    CGFloat btnW = ScreenW/2;
    CGFloat btnY = ScreenH - btnH;
    for (NSInteger i = 0; i < titles.count; i ++) {
        PLLIRLButton *button = [PLLIRLButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = PFR14Font;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.tag = i;
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(i*btnW, btnY, btnW, btnH);
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.frame = CGRectMake(ScreenW*0.5 - 0.5, ScreenH - 38, 1, 30);
    verticalLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:verticalLine];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLHelpBackSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLHelpBackSquareCellID forIndexPath:indexPath];
    NSArray *titles = @[@"安全支付",@"配送流程",@"售后服务",@"自提",@"优惠券",@"常见问题"];
    NSArray *images = @[@"zf_bestPay",@"ZC_Music",@"ZC_Rankings",@"ZC_Science",@"ZC_Travel",@"ZC_More"];
    
    cell.titleLabel.text = titles[indexPath.row];
    cell.squareImageView.image = [UIImage imageNamed:images[indexPath.row]];
    return cell;
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了帮组的反馈Item");
}
#pragma mark - 点击事件
- (void)bottomBtnClick:(UIButton *)sender {
    NSLog(@"%@",(sender.tag == 0) ? @"DC电话" : @"在线客服");
}
- (void)feedbackItemClick {
    NSLog(@"反馈");
}
@end
