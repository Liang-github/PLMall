//
//  PLShowTypeThreeCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLShowTypeThreeCell.h"

@implementation PLShowTypeThreeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}
- (void)setUpData {
    self.isHasindicateButton = NO;
    self.leftTitleLabel.text = @"运费";
    self.contentLabel.text = @"免运费";
    self.hintLabel.text = @"支持7天无理由退货";
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.hintLabel.font = PFR10Font;
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"icon_duigou_small"];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(PLMargin);
        make.centerY.equalTo(self.leftTitleLabel);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel);
        make.top.equalTo(self.leftTitleLabel.mas_bottom).offset(PLMargin);
    }];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(PLMargin);
        make.centerY.equalTo(self.iconImageView);
    }];
}

@end
