//
//  PLNavSearchBarView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLNavSearchBarView.h"

@implementation PLNavSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    
    _placeholdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _placeholdLabel.font = PFR14Font;
    _placeholdLabel.textColor = [UIColor whiteColor];
    
    _voiceImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_voiceImageBtn setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [_voiceImageBtn addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_placeholdLabel];
    [self addSubview:_voiceImageBtn];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _placeholdLabel.frame = CGRectMake(PLMargin, 0, self.pl_width - 50, self.pl_height);
    
    [_placeholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.top.equalTo(self);
        make.height.equalTo(self);
    }];
    [_voiceImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-PLMargin);
        make.top.equalTo(self);
        make.height.equalTo(self);
    }];
    //设置边角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(2, 2)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];
}
#pragma mark - Setter Getter Methods
- (void)searchClick {
    !_searchViewBlock ? : _searchViewBlock();
}
#pragma mark - 语音点击回调
- (void)voiceButtonClick {
    !_voiceButtonClickBlock ? : _voiceButtonClickBlock();
}
@end
