//
//  PLCommentPicItem.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLCommentPicItem : NSObject
//用户名
@property (nonatomic, copy) NSString *nickname;
//图片
@property (nonatomic, strong) NSArray *images;
@end
