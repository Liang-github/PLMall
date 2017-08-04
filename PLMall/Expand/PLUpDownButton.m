//
//  PLUpDownButton.m
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLUpDownButton.h"

@implementation PLUpDownButton

- (void)setUp {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = PFR12Font;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.pl_centerX = self.pl_width*0.5;
    self.imageView.pl_centerY = self.pl_height*0.3;
    [self.titleLabel sizeToFit];
    self.titleLabel.pl_centerX = self.pl_width*0.5;
    self.titleLabel.pl_y = self.imageView.pl_bottom + 5;
}
@end
