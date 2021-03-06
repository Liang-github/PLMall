//
//  UIImage+PLCircle.m
//  PLMall
//
//  Created by PengLiang on 2017/8/3.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "UIImage+PLCircle.h"

@implementation UIImage (PLCircle)

- (instancetype)circleImage {
    //开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    //上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪
    CGContextClip(ctx);
    //绘制图片
    [self drawInRect:rect];
    //获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsGetCurrentContext();
    return image;
}
+ (instancetype)circleImage:(NSString *)name {
    return [[self circleImage:name] circleImage];
}

@end
