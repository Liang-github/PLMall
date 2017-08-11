//
//  PLGoodsSortCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLGoodsSortCell.h"
#import "PLClassMainItem.h"
#import "PLClassSubItem.h"
#import <UIImageView+WebCache.h>

@interface PLGoodsSortCell ()

//imageView
@property (nonatomic, strong) UIImageView *goodsImageView;
//Label
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@end

@implementation PLGoodsSortCell

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
    self.backgroundColor = PLBGColor;
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    _goodsTitleLabel = [[UILabel alloc] init];
    _goodsTitleLabel.font = PFR13Font;
    _goodsTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_goodsTitleLabel];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.pl_width*0.85, self.pl_width*0.85));
    }];
    [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsImageView.mas_bottom).offset(5);
        make.width.equalTo(_goodsImageView);
        make.centerX.equalTo(self);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setSubItem:(PLClassSubItem *)subItem {
    _subItem = subItem;
    if ([subItem.image_url containsString:@"http"]) {
        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:subItem.image_url]];
    } else {
        _goodsImageView.image = [UIImage imageNamed:subItem.image_url];
    }
    _goodsTitleLabel.text = subItem.goods_title;
}
@end
