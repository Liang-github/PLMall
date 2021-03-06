//
//  PLMessageItem.h
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLMessageItem : NSObject

//标题
@property (nonatomic, copy, readonly) NSString *title;
//图片
@property (nonatomic, copy, readonly) NSString *imageName;
//消息
@property (nonatomic, copy, readonly) NSString *message;
@end
