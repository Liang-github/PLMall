//
//  PLPartCommentHeadView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLPartCommentHeadView.h"
#import "UIImage+PLCircle.h"

@interface PLPartCommentHeadView ()

//文字评论
@property (nonatomic, strong) UIView *commentTextView;
//图片头部
@property (nonatomic, strong) UIView *picHeadView;
//图片数量
@property (nonatomic, strong) UILabel *picNumLabel;
//指示按钮
@property (nonatomic, strong) UIButton *indicateButton;
//头像
@property (nonatomic, strong) UIImageView *iconIamgeView;
//昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
//评论内容
@property (nonatomic, strong) UILabel *contentLabel;
//时间
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation PLPartCommentHeadView
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
    [self setUpTextComment];
    [self setUpPicHead];
}
#pragma mark - 文字评论
- (void)setUpTextComment {
    _commentTextView = [[UIView alloc] init];
    [self addSubview:_commentTextView];
    
    PLUserInfo *userInfo = UserInfoData;
    _iconIamgeView = [[UIImageView alloc] init];
    _iconIamgeView.image = [[UIImage imageNamed:userInfo.userimage] circleImage];
    
    [_commentTextView addSubview:_iconIamgeView];
    
    _nicknameLabel = [[UILabel alloc] init];
    _nicknameLabel.font = PFR11Font;
    _nicknameLabel.text = [PLSpeedy pl_encryptionDisplayMessageWith:userInfo.nickname withFirstIndex:2];
    [_commentTextView addSubview:_nicknameLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR12Font;
    _contentLabel.text = @"如果Demo对你有所帮助，别忘了点星支持下！";
    [_commentTextView addSubview:_contentLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [UIColor lightGrayColor];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"YY-MM-dd";
    NSString *currentDateStr = [fmt stringFromDate:[NSDate date]];
    _timeLabel.text = currentDateStr;
    _timeLabel.font = PFR10Font;
    [self addSubview:_timeLabel];
}
#pragma mark - 图片头部
- (void)setUpPicHead {
    _picHeadView = [[UIView alloc] init];
    [self addSubview:_picHeadView];
    
    _picNumLabel = [[UILabel alloc] init];
    _picNumLabel.font = PFR12Font;
    [_picHeadView addSubview:_picNumLabel];
    
    _indicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
    [_picHeadView addSubview:_indicateButton];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //图片头部布局
    [self setUpLayoutpicHeadViewSubviews];
    //文字评论布局
    [self setUpLayoutcommentTextViewSubviews];
}
#pragma mark - 图片头部布局
- (void)setUpLayoutpicHeadViewSubviews {
    [_picHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@25);
    }];
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.equalTo(self);
        make.bottom.equalTo(_picHeadView.mas_top);
    }];
    [_picNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.centerY.equalTo(_picHeadView);
    }];
    [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-PLMargin);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(_picHeadView);
    }];
}
#pragma mark - 文字评论布局
- (void)setUpLayoutcommentTextViewSubviews {
    [_iconIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commentTextView).offset(PLMargin);
        make.top.equalTo(_commentTextView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconIamgeView.mas_right);
        make.centerY.equalTo(_iconIamgeView);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconIamgeView);
        make.right.equalTo(_commentTextView).offset(-PLMargin);
        make.top.equalTo(_iconIamgeView.mas_bottom).offset(5);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom);
        make.left.equalTo(_contentLabel);
        make.bottom.equalTo(_commentTextView);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setPicNum:(NSString *)picNum {
    _picNum = picNum;
    _picNumLabel.text = [NSString stringWithFormat:@"有图评价（%@）",picNum];
}
@end
