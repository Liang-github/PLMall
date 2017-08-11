//
//  PLBrandSortCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLBrandSortCell.h"
#import "PLClassMainItem.h"
#import "PLClassSubItem.h"
#import <UIImageView+WebCache.h>

@interface PLBrandSortCell ()

//imageView
@property (nonatomic, strong) UIImageView *brandImageView;
@end

@implementation PLBrandSortCell

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
    _brandImageView = [[UIImageView alloc] init];
    _brandImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_brandImageView];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.pl_width - 20, self.pl_height - 25));
    }];
}
#pragma mark - Setter Getter Methods
- (void)setSubItem:(PLClassSubItem *)subItem {
    _subItem = subItem;
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:subItem.image_url]];
}
@end
