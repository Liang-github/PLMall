//
//  PLFeatureChoseCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLFeatureChoseTopCell.h"

@interface PLFeatureChoseTopCell ()
//取消
@property (nonatomic, strong) UIButton *crossButton;
@end
@implementation PLFeatureChoseTopCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)setUpUI {
    _crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_crossButton setImage:[UIImage imageNamed:@"icon_cha"] forState:0];
    [_crossButton addTarget:self action:@selector(crossButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_crossButton];
    
    _goodImageView = [UIImageView new];
    [self addSubview:_goodImageView];
    
    _goodPriceLabel = [UILabel new];
    _goodPriceLabel.font = PFR18Font;
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];
    
    _chooseAttLabel = [UILabel new];
    _chooseAttLabel.numberOfLines = 2;
    _chooseAttLabel.font = PFR14Font;
    [self addSubview:_chooseAttLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_crossButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-PLMargin);
        make.top.equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.top.equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodImageView.mas_right).offset(PLMargin);
        make.top.equalTo(_goodImageView).offset(PLMargin);
    }];
    [_chooseAttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodPriceLabel);
        make.right.equalTo(_crossButton.mas_left);
        make.top.equalTo(_goodPriceLabel.mas_bottom).offset(5);
    }];
}
- (void)crossButtonClick {
    !_crossButtonClickBlock ? : _crossButtonClickBlock();
}
@end
