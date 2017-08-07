//
//  PLHelpBackSquareCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLHelpBackSquareCell.h"

@implementation PLHelpBackSquareCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _squareImageView = [[UIImageView alloc] init];
    _squareImageView.contentMode = UIViewContentModeScaleAspectFit; //自适应
    [self addSubview:_squareImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR14Font;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_titleLabel];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_squareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(PLMargin*3);
        make.size.mas_equalTo(CGSizeMake(self.pl_width - PLMargin*8, self.pl_width - PLMargin*8));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(_squareImageView.mas_bottom).offset(PLMargin);
    }];
}
@end
