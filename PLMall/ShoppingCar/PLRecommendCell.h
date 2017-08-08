//
//  PLRecommendCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLRecomendItem;
@interface PLRecommendCell : UICollectionViewCell
//推荐商品数据
@property (nonatomic, strong) PLRecomendItem *recommendItem;
@end
