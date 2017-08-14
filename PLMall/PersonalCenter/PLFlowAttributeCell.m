//
//  PLFlowAttributeCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLFlowAttributeCell.h"
#import "PLFlowItem.h"

@interface PLFlowAttributeCell ()

@end

@implementation PLFlowAttributeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.lastIsImageView = NO; //默认为NO
    _flowImageView = [[UIImageView alloc] init];
    _flowImageView.contentMode = UIViewContentModeScaleToFill;
    
    _flowTextLabel = [[UILabel alloc] init];
    _flowTextLabel.font = PFR13Font;
    _flowTextLabel.textAlignment = NSTextAlignmentCenter;
    
    _flowNumLabel = [[UILabel alloc] init];
    _flowNumLabel.textAlignment = NSTextAlignmentCenter;
    _flowNumLabel.font = [UIFont fontWithName:@"PingFangSC-Bold" size:14];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_type == PLFlowTypeImage) {
        [self addSubview:_flowImageView];
        [self addSubview:_flowTextLabel];
        
        [self setUpTypeWithTopImageViewBottonLabel];
    } else {
        [self addSubview:_flowTextLabel];
        if (_lastIsImageView) {
            [self addSubview:_flowImageView];
            [self setUpTypeWithTopImageViewBottonLabel];
        } else {
            [self addSubview:_flowNumLabel];
            [self setUpTypeWithTopLabelBottonLabel];
        }
    }
}
#pragma mark - typeOne
- (void)setUpTypeWithTopImageViewBottonLabel {
    [_flowNumLabel removeFromSuperview];
    
    [_flowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [_flowTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_flowImageView.mas_bottom);
        make.centerX.mas_equalTo(self);
    }];
}

#pragma mark - typeTwo
- (void)setUpTypeWithTopLabelBottonLabel {
    [_flowImageView removeFromSuperview];
    
    [_flowNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [_flowTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_flowNumLabel.mas_bottom).offset(4);
        make.centerX.mas_equalTo(self);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setFlowItem:(PLFlowItem *)flowItem {
    _flowItem = flowItem;
    
    _flowImageView.image = [UIImage imageNamed:flowItem.flowImageView];
    _flowTextLabel.text = flowItem.flow_title;
}
@end
