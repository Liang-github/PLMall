//
//  PLOverFootView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLOverFootView.h"
@interface PLOverFootView ()
@property (nonatomic, strong) UILabel *overLabel;
@end
@implementation PLOverFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _overLabel = [[UILabel alloc] init];
    _overLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_overLabel];
    _overLabel.font = PFR16Font;
    _overLabel.textColor = [UIColor darkGrayColor];
    _overLabel.text = @"看完喽，下次再逛吧";
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}
@end
