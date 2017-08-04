//
//  PLCustionButton.m
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLCustionButton.h"

@interface PLCustionButton ()
@end
@implementation PLCustionButton

#pragma mark - Intail
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.titleLabel.font = PFR14Font;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
    //计算完加一个间距
    self.pl_width += PLMargin;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.pl_x = self.pl_width*0.3;
    self.imageView.pl_x = CGRectGetMaxX(self.titleLabel.frame) + PLMargin;
}
@end
