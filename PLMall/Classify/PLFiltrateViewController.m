//
//  PLFiltrateViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#define FiltrateViewScreenW ScreenW*0.7

#import "PLFiltrateViewController.h"

#import "PLFiltrateItem.h"

#import "PLFeatureHeaderView.h"

#import <MJExtension.h>
#import "UIViewController+XWTransition.h"

@interface PLFiltrateViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
//筛选父View
@property (nonatomic, strong) UIView *filtrateConView;
//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<PLFiltrateItem *> *filtrateItem;

@end

static NSString *const PLFiltrateAttrCellID = @"PLFiltrateAttrCell";
static NSString *const PLFiltrateHeaderViewID = @"PLFiltrateHeaderView";
@implementation PLFiltrateViewController
#pragma mark - LazyLoad
//- (UICollectionView *)collectionView {
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        _collectionView.dataSource = self;
//        _collectionView.delegate = self;
//        _collectionView.alwaysBounceVertical = YES;
//        
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
