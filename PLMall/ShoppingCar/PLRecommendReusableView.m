//
//  PLRecommendReusableView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLRecommendReusableView.h"

@interface PLRecommendReusableView ()
//头部推荐标题

@property (nonatomic, strong) UILabel *recommendLabel;

@end
@implementation PLRecommendReusableView
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _recommendLabel = [[UILabel alloc] init];
    _recommendLabel.text = @"大家都在买";
    _recommendLabel.textColor = [UIColor darkGrayColor];
    _recommendLabel.font = PFR14Font;
    [self addSubview:_recommendLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(PLMargin);
    }];
}
@end
