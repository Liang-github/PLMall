//
//  PLShareItemCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLShareItemCell.h"
#import "PLShareItem.h"
#import <UIImageView+WebCache.h>

@interface PLShareItemCell ()
//图片
@property (nonatomic, strong) UIImageView *shareImageView;
//品台
@property (nonatomic, strong) UILabel *shareLabel;
@end
@implementation PLShareItemCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    
    _shareImageView = [UIImageView new];
    [self addSubview:_shareImageView];
    
    _shareLabel = [UILabel new];
    _shareLabel.textAlignment = NSTextAlignmentCenter;
    _shareLabel.textColor = [UIColor darkGrayColor];
    _shareLabel.font = PFR13Font;
    [self addSubview:_shareLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(43, 43));
    }];
    [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shareImageView.mas_bottom).offset(PLMargin);
        make.centerX.equalTo(self);
    }];
}
- (void)setShareItem:(PLShareItem *)shareItem {
    _shareItem = shareItem;
    self.shareLabel.text = shareItem.terrace;
    self.shareImageView.image = [UIImage imageNamed:shareItem.iconImage];
}
@end
