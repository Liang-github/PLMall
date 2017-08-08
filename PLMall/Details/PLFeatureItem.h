//
//  PLFeatureItem.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PLFeatureTitleItem, PLFeatureList;
@interface PLFeatureItem : NSObject
//名字
@property (nonatomic, strong) PLFeatureTitleItem *attr;
//数组
@property (nonatomic, strong) NSArray<PLFeatureList *> *list;
@end
