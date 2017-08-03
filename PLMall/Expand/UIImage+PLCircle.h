//
//  UIImage+PLCircle.h
//  PLMall
//
//  Created by PengLiang on 2017/8/3.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PLCircle)

//返回圆形图片
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;

@end
