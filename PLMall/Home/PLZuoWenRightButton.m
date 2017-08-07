//
//  PLZuoWenRightButton.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLZuoWenRightButton.h"

@implementation PLZuoWenRightButton

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置label
    self.titleLabel.pl_x = 0;
    self.titleLabel.pl_centerY = self.pl_centerY;
    [self.titleLabel sizeToFit];
    
    //设置图片位置
    self.imageView.pl_x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.pl_centerY = self.pl_centerY;
    [self.imageView sizeToFit];
}
@end
