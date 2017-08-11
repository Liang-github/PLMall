//
//  PLFeatureItemCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PLFeatureList;
@interface PLFeatureItemCell : UICollectionViewCell
//内容数据
@property (nonatomic, copy) PLFeatureList *content;
@end
