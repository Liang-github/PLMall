//
//  PLGoodsYouLikeCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//
#define cellWH ScreenW*0.5 - 50
#import "PLGoodsYouLikeCell.h"
#import "PLRecomendItem.h"
#import <UIImageView+WebCache.h>

@interface PLGoodsYouLikeCell ()
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end
@implementation PLGoodsYouLikeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR12Font;
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR15Font;
    [self addSubview:_priceLabel];
    
    _sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sameButton.titleLabel.font = PFR10Font;
    [_sameButton setTitleColor:[UIColor darkGrayColor] forState:0];
    [_sameButton setTitle:@"看相似" forState:0];
    [_sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sameButton];
    [PLSpeedy pl_changeControlCircularWith:_sameButton andSetCornerRadius:0 setBorderWidth:1 setBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(cellWH, cellWH));
    }];
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.8);
        make.height.equalTo(@40);
        make.top.equalTo(_goodsImageView.mas_bottom).offset(PLMargin);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsImageView);
        make.width.equalTo(self).multipliedBy(0.5);
        make.top.equalTo(_goodsLabel.mas_bottom);
    }];
    [_sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-PLMargin);
        make.centerY.equalTo(_priceLabel);
        make.size.mas_equalTo(CGSizeMake(35, 18));
    }];
}
- (void)setYouLikeItem:(PLRecomendItem *)youLikeItem {
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[youLikeItem.price floatValue]];
    _goodsLabel.text = youLikeItem.main_title;
}
- (void)lookSameGoods {
    !_lookSameBlock ? : _lookSameBlock();
}
@end
