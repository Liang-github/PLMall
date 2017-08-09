//
//  PLDetailLikeItemCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailLikeItemCell.h"
#import "PLRecomendItem.h"
#import <UIImageView+WebCache.h>

@interface PLDetailLikeItemCell ()
//图片
@property (nonatomic, strong) UIImageView *goodsImageView;
//标题
@property (nonatomic, strong) UILabel *goodsLabel;
//价格
@property (nonatomic, strong) UILabel *priceLabel;
@end
@implementation PLDetailLikeItemCell

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
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.font = PFR14Font;
    [self addSubview:_priceLabel];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR11Font;
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textColor = [UIColor darkGrayColor];
    _goodsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_goodsLabel];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.width.equalTo(self.mas_width).multipliedBy(0.75);
        make.height.equalTo(self.mas_width).multipliedBy(0.75);
        make.centerX.equalTo(self);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.top.equalTo(_goodsImageView.mas_bottom).offset(2);
    }];
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.right.equalTo(self).offset(-PLMargin);
        make.top.equalTo(_priceLabel.mas_bottom).offset(2);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setYouLikeItem:(PLRecomendItem *)youLikeItem {
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[youLikeItem.price floatValue]];
    _goodsLabel.text = youLikeItem.main_title;
}
@end
