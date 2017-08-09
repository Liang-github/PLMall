//
//  PLFeatureHeaderView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLFeatureTitleItem;
@interface PLFeatureHeaderView : UICollectionReusableView
//标题数据
@property (nonatomic, strong) PLFeatureTitleItem *headTitle;
@end
