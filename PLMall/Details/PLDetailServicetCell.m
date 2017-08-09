//
//  PLDetailServicetCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailServicetCell.h"

@implementation PLDetailServicetCell

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
    _serviceButton = [[PLLIRLButton alloc] init];
    [_serviceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _serviceButton.titleLabel.font = PFR13Font;
    [self addSubview:_serviceButton];
    
    _serviceLabel = [[UILabel alloc] init];
    _serviceLabel.textColor = [UIColor lightGrayColor];
    _serviceLabel.font = PFR12Font;
    _serviceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_serviceLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(3);
        make.centerX.equalTo(self);
    }];
    
    [_serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serviceButton.mas_bottom).offset(5);
        make.centerX.equalTo(self);
    }];
}
@end
