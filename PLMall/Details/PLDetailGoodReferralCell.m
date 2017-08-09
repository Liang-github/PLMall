//
//  PLDetailGoodReferralCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailGoodReferralCell.h"
#import "PLUpDownButton.h"

@interface PLDetailGoodReferralCell ()

//自营
@property (nonatomic, strong) UIImageView *autotrophyImageView;
//分享按钮
@property (nonatomic, strong) PLUpDownButton *shareButton;
@end
@implementation PLDetailGoodReferralCell

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
    
    _autotrophyImageView = [[UIImageView alloc] init];
    [self addSubview:_autotrophyImageView];
    _autotrophyImageView.image = [UIImage imageNamed:@"detail_title_ziying_tag"];
    
    _goodTitleLabel = [[UILabel alloc] init];
    _goodTitleLabel.font = PFR16Font;
    _goodTitleLabel.numberOfLines = 0;
    [self addSubview:_goodTitleLabel];
    
    _goodPriceLabel = [[UILabel alloc] init];
    _goodPriceLabel.font = PFR20Font;
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];
    
    _goodSubtitleLabel = [[UILabel alloc] init];
    _goodSubtitleLabel.font = PFR12Font;
    _goodSubtitleLabel.numberOfLines = 0;
    _goodSubtitleLabel.textColor = RGB(233, 35, 46);
    [self addSubview:_goodSubtitleLabel];
    
    _shareButton = [PLUpDownButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setTitle:@"分享" forState:0];
    [_shareButton setImage:[UIImage imageNamed:@"icon_fenxiang2"] forState:0];
    [_shareButton setTitleColor:[UIColor blackColor] forState:0];
    _shareButton.titleLabel.font = PFR10Font;
    [self addSubview:_shareButton];
    [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [PLSpeedy pl_setUpAcrossPartingLineWith:self withColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.15]];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_autotrophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.top.equalTo(self).offset(PLMargin);
    }];
    [_goodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.top.equalTo(_autotrophyImageView).offset(-3);
        make.right.equalTo(self).offset(-PLMargin*5);
    }];
    [_goodSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_autotrophyImageView);
        make.right.equalTo(self).offset(-PLMargin*5);
        make.top.equalTo(_goodTitleLabel.mas_bottom).offset(PLMargin);
    }];
    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_autotrophyImageView);
        make.top.equalTo(_goodSubtitleLabel.mas_bottom).offset(PLMargin);
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-PLMargin);
        make.top.equalTo(self).offset(PLMargin);
    }];
    [PLSpeedy pl_setUpLongLineWith:_goodTitleLabel withColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.15] withHightRatio:0.6];
}
#pragma mark - 分享按钮点击
- (void)shareButtonClick {
    !_shareButtonClickBlock ? : _shareButtonClickBlock();
}
@end
