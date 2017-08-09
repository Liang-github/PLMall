//
//  PLCommentCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLCommentCell.h"
@interface PLCommentCell ()

//头像
@property (nonatomic, strong) UIImageView *iconImageView;
//昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
//评论内容
@property (nonatomic, strong) UILabel *contentLabel;
//规格
@property (nonatomic, strong) UILabel *etalonLabel;
//时间
@property (nonatomic, strong) UILabel *timeLabel;
@end


@implementation PLCommentCell

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
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_iconImageView];
    
    _nicknameLabel = [[UILabel alloc] init];
    _nicknameLabel.font = PFR11Font;
    [self addSubview:_nicknameLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR12Font;
    [self addSubview:_contentLabel];
    
    _etalonLabel = [[UILabel alloc] init];
    _etalonLabel.textColor = [UIColor lightGrayColor];
    _etalonLabel.font = PFR11Font;
    [self addSubview:_etalonLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = PFR10Font;
    [self addSubview:_timeLabel];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.top.equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(PLMargin);
        make.centerY.equalTo(_iconImageView);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView);
        make.right.equalTo(self).offset(-PLMargin);
        make.top.equalTo(_iconImageView.mas_bottom).offset(PLMargin);
    }];
    [_etalonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView);
        make.right.equalTo(self).offset(-PLMargin);
        make.top.equalTo(_contentLabel.mas_bottom).offset(PLMargin);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView);
    }];
    
}
@end
