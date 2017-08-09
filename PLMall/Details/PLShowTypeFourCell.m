//
//  PLShowTypeFourCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLShowTypeFourCell.h"

@implementation PLShowTypeFourCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}
- (void)setUpData {
    self.leftTitleLabel.text = @"领券";
    [self addSubview:self.iconImageView];
    
    self.iconImageView.image = [UIImage imageNamed:@"biaoqian"];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //重写leftTitleLabelFrame
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.centerY.equalTo(self);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(PLMargin);
        make.centerY.equalTo(self.leftTitleLabel);
    }];
}

@end
