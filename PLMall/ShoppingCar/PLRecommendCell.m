//
//  PLRecommendCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLRecommendCell.h"

#import "PLRecomendItem.h"

#import <UIImageView+WebCache.h>

@interface PLRecommendCell ()
//图片
@property (nonatomic, strong) UIImageView *goodsImageView;
//标题
@property (nonatomic, strong) UILabel *goodsLabel;
//价格
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation PLRecommendCell
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
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR12Font;
    _goodsLabel.numberOfLines = 0;
    _goodsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR12Font;
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLabel];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(self.pl_width*0.7, self.pl_width*0.7));
    }];
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.8);
        make.top.equalTo(_goodsImageView.mas_bottom).offset(PLMargin);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.8);
        make.top.equalTo(_goodsLabel.mas_bottom);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setRecommendItem:(PLRecomendItem *)recommendItem {
    _recommendItem = recommendItem;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:recommendItem.image_url]];
    _goodsLabel.text = recommendItem.main_title;
    
    _priceLabel.text = ([recommendItem.price integerValue] >= 10000) ? [NSString stringWithFormat:@"￥%.2f万",[recommendItem.price floatValue] / 10000.0] : [NSString stringWithFormat:@"¥ %.2f",[recommendItem.price floatValue]];
}


@end
