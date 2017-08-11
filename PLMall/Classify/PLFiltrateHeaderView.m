//
//  PLFiltrateHeaderView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//
#define FiltrateViewScreenW ScreenW*0.7
#import "PLFiltrateHeaderView.h"

@interface PLFiltrateHeaderView ()

//标题
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end
@implementation PLFiltrateHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = PFR15Font;
    [self addSubview:_titleLabel];
    
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"goodsDetail_jiantou_xia"];
    _arrowImageView.userInteractionEnabled = YES;
    _arrowImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_arrowImageView];
    
    [_arrowImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionDidClick)]];
}
#pragma mark - 展开列表点击事件
- (void)sectionDidClick {
    [UIView animateWithDuration:0.25 animations:^{
        self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
    }];
    !_sectionClick ? : _sectionClick();
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(5, PLMargin, 100, 35);
    
    _arrowImageView.frame = CGRectMake(FiltrateViewScreenW - 45, PLMargin, 35, 35);
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
@end
