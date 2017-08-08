//
//  PLClassMainItem.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PLClassSubItem;

@interface PLClassMainItem : NSObject

//文标题
@property (nonatomic, copy, readonly) NSString *title;
//goods
@property (nonatomic, copy, readonly) NSArray<PLClassSubItem *> *goods;
@end
