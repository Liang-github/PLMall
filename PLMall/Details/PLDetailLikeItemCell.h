//
//  PLDetailLikeItemCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLRecomendItem;
@interface PLDetailLikeItemCell : UICollectionViewCell
//推荐数据
@property (nonatomic, strong) PLRecomendItem *youLikeItem;
@end
