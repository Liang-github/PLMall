//
//  UIImageView+PLExtension.m
//  PLMall
//
//  Created by PengLiang on 2017/8/3.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "UIImageView+PLExtension.h"
#import "UIImage+PLCircle.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (PLExtension)
- (void)setHeader:(NSString *)url {
    __weak typeof(self)weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.image = image ? [image circleImage] : nil;
    }];
}
@end
