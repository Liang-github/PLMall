//
//  PLShowTypeTwoCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLShowTypeTwoCell.h"

@implementation PLShowTypeTwoCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}
- (void)setUpData {
    self.leftTitleLabel.text = @"送至";
    self.hintLabel.text = @"由DC商贸配送监管";
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.hintLabel.font = PFR12Font;
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"ptgd_icon_dizhi"];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(PLMargin);
        make.centerY.equalTo(self.leftTitleLabel);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(PLMargin);
        make.centerY.equalTo(self.leftTitleLabel);
    }];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(8);
    }];
}
@end
