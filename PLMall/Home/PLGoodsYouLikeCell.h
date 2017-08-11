//
//  PLGoodsYouLikeCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLRecomendItem;
@interface PLGoodsYouLikeCell : UICollectionViewCell

@property (nonatomic, strong) PLRecomendItem *youLikeItem;
@property (nonatomic, strong) UIButton *sameButton;
@property (nonatomic, copy) dispatch_block_t lookSameBlock;

@end
