//
//  PLFeatureList.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLFeatureList : NSObject
//类型名
@property (nonatomic, copy) NSString *infoname;
//额外价格
@property (nonatomic, copy) NSString *plusprice;
//是否点击
@property (nonatomic, assign) BOOL isSelect;
@end
