//
//  PLFootprintCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#define FootprintScreenW ScreenW*0.4
#import "PLFootprintCell.h"
#import "PLRecomendItem.h"
#import <UIImageView+WebCache.h>

@interface PLFootprintCell ()

//图片
@property (nonatomic, strong) UIImageView *goodImageView;
//商品名称
@property (nonatomic, strong) UILabel *goodName;
//商品价格
@property (nonatomic, strong) UILabel *priceLabel;

@end
@implementation PLFootprintCell
#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI {
    self.selectionStyle = 0;
    
    _goodImageView = [[UIImageView alloc] init];
    _goodImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodImageView];
    
    _goodName = [[UILabel alloc] init];
    _goodName.font = PFR12Font;
    [self addSubview:_goodName];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR13Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(FootprintScreenW*0.9, FootprintScreenW*0.9));
    }];
    [_goodName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodImageView.mas_bottom).offset(5);
        make.left.equalTo(_goodImageView);
        make.right.equalTo(_goodImageView);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodName.mas_bottom).offset(5);
        make.left.equalTo(_goodImageView);
        make.right.equalTo(_goodImageView);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setFootprintItem:(PLRecomendItem *)footprintItem {
    _footprintItem = footprintItem;
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:footprintItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"￥%2f",[footprintItem.price floatValue]];
    _goodName.text = footprintItem.main_title;
}
@end
