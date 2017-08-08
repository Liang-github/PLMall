//
//  PLFiltrateItem.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLFiltrateItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<NSString *> *header;
@property (nonatomic, strong) NSArray<NSString *> *content;
//用于判断当前cell是否展开
@property (nonatomic, assign, getter=isOpen) BOOL open;
@end
