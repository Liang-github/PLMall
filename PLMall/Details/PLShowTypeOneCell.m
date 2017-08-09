//
//  PLShowTypeOneCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLShowTypeOneCell.h"

@implementation PLShowTypeOneCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}
- (void)setUpData {
    self.hintLabel.text = @"可选增值服务";
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.hintLabel.font = PFR12Font;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(PLMargin);
        make.width.equalTo(self).multipliedBy(0.78);
        make.centerY.equalTo(self.leftTitleLabel);
    }];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(8);
    }];
}
@end
