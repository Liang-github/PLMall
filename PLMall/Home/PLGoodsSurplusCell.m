//
//  PLGoodsSurplusCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLGoodsSurplusCell.h"
#import "PLRecomendItem.h"
#import <UIImageView+WebCache.h>

@interface PLGoodsSurplusCell ()

@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *stockLabel;
@property (nonatomic, strong) UILabel *natureLabel;
@end
@implementation PLGoodsSurplusCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR12Font;
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLabel];
    
    _stockLabel = [[UILabel alloc] init];
    _stockLabel.textColor = [UIColor darkGrayColor];
    _stockLabel.font = PFR10Font;
    _stockLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_stockLabel];
    
    _natureLabel = [[UILabel alloc] init];
    _natureLabel.textAlignment = NSTextAlignmentCenter;
    _natureLabel.backgroundColor = [UIColor redColor];
    _natureLabel.font = PFR10Font;
    _natureLabel.textColor = [UIColor whiteColor];
    [_goodsImageView addSubview:_natureLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(self.pl_width*0.8);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsImageView.mas_bottom).offset(2);
        make.centerX.equalTo(self);
    }];
    [_stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_bottom).offset(2);
        make.centerX.equalTo(self);
    }];
    [_natureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_goodsImageView.mas_bottom);
        make.left.equalTo(_goodsImageView);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
}
- (void)setRecommendItem:(PLRecomendItem *)recommendItem {
    _recommendItem = recommendItem;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:recommendItem.image_url]];
    
    _priceLabel.text = ([recommendItem.price integerValue] >= 10000) ? [NSString stringWithFormat:@"¥ %.2f万",[recommendItem.price floatValue] / 10000.0] : [NSString stringWithFormat:@"¥ %.2f",[recommendItem.price floatValue]];
    _stockLabel.text = [NSString stringWithFormat:@"仅剩：%@件",recommendItem.stock];
    _natureLabel.text = recommendItem.nature;
}
@end
