//
//  PLLIRLButton.m
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLLIRLButton.h"

@implementation PLLIRLButton

#pragma mark - Intial

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.pl_centerX = self.pl_width*0.55;
    self.imageView.pl_x = self.titleLabel.pl_x - self.imageView.pl_width - 5;
}

@end
