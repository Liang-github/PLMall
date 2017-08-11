//
//  PLCommodityViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//
#define tableViewH 100
#import "PLCommodityViewController.h"

//Controllers
#import "PLGoodsSetViewController.h"
//Models
#import "PLClassMainItem.h"
#import "PLClassSubItem.h"
#import "PLClassGoodsItem.h"
//Views
#import "PLNavSearchBarView.h"
#import "PLClassCategoryCell.h"
#import "PLGoodsSortCell.h"
#import "PLBrandSortCell.h"
#import "PLBrandsSortHeadView.h"
//Vendors
#import <MJExtension.h>
@interface PLCommodityViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<PLClassGoodsItem *> *titleItem;
@property (nonatomic, strong) NSMutableArray<PLClassMainItem *> *mainItem;

@end
static NSString *const PLClassCategoryCellID = @"PLClassCategoryCell";
static NSString *const PLBrandsSortHeadViewID = @"PLBrandsSortHeadView";
static NSString *const PLGoodsSortCellID = @"PLGoodsSortCell";
static NSString *const PLBrandSortCellID = @"PLBrandSortCell";
@implementation PLCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
