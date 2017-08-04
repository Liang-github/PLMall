//
//  PLGridItem.h
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLGridItem : NSObject

//图片
@property (nonatomic, copy, readonly) NSString *iconImage;
//文字
@property (nonatomic, copy, readonly) NSString *gridTitle;
@end
