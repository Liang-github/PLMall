//
//  PLClassGoodsItem.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLClassGoodsItem : NSObject

//文标题
@property (nonatomic, copy, readonly) NSString *title;
//plist
@property (nonatomic, copy, readonly) NSString *fileName;
@end
