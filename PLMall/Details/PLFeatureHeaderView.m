//
//  PLFeatureHeaderView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLFeatureHeaderView.h"
#import "PLFeatureTitleItem.h"

@interface PLFeatureHeaderView ()

//属性标题
@property (nonatomic, strong) UILabel *headerLabel;
//底部View
@property (nonatomic, strong) UIView *bottomView;

@end
@implementation PLFeatureHeaderView
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font = PFR15Font;
    [self addSubview:_headerLabel];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:_bottomView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.centerY.equalTo(self);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(PLMargin);
        make.right.mas_equalTo(-PLMargin);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(PLFeatureTitleItem *)headTitle {
    _headTitle = headTitle;
    _headerLabel.text = headTitle.attrname;
}
@end
