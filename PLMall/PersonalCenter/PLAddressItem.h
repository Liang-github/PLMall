//
//  PLAddressItem.h
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "JKDBModel.h"

@interface PLAddressItem : JKDBModel

@property (nonatomic, copy) NSString *adName;

@property (nonatomic, copy) NSString *adPhone;

@property (nonatomic, copy) NSString *adCity;

@property (nonatomic, copy) NSString *adDetail;

//是否默认地址
@property (nonatomic, assign) BOOL isDefault;
//cell行高
@property (nonatomic, assign) CGFloat cellHeight;
@end
