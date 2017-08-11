//
//  PLListGridCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLRecomendItem;
@interface PLListGridCell : UICollectionViewCell
//推荐数据
@property (nonatomic, strong) PLRecomendItem *youSelectItem;
//冒号点击回调
@property (nonatomic, copy) dispatch_block_t colonClickBlock;
@end
