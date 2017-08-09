//
//  PLShareItemCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PLShareItem;
@interface PLShareItemCell : UICollectionViewCell
//分享数据
@property (nonatomic, strong) PLShareItem *shareItem;
@end
