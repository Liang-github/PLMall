//
//  PLDetailShowTypeCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailShowTypeCell.h"

@implementation PLDetailShowTypeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    
    _leftTitleLabel = [[UILabel alloc] init];
    _leftTitleLabel.font = PFR14Font;
    _leftTitleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_leftTitleLabel];
    
    _iconImageView = [[UIImageView alloc] init];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR14Font;
    [self addSubview:_hintLabel];
    
    _indicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
    _isHasindicateButton = YES;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.top.equalTo(self).offset(PLMargin);
    }];
    if (_isHasindicateButton) {
        [self addSubview:_indicateButton];
        [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-PLMargin);
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.equalTo(self);
        }];
    }
}
@end
