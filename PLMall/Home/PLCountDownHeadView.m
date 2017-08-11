//
//  PLCountDownHeadView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLCountDownHeadView.h"
#import "PLZuoWenRightButton.h"

@interface PLCountDownHeadView ()

//红色块
@property (nonatomic, strong) UIView *redView;
//时间
@property (nonatomic, strong) UILabel *timeLabel;
//倒计时
@property (nonatomic, strong) UILabel *countDownLabel;
//好货秒抢
@property (nonatomic, strong) PLZuoWenRightButton *quickButton;
@end
@implementation PLCountDownHeadView

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
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    [self addSubview:_redView];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"六点场";
    _timeLabel.font = PFR16Font;
    [self addSubview:_timeLabel];
    
    _countDownLabel = [[UILabel alloc] init];
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.text = @"05 : 58 : 33";
    _countDownLabel.font = PFR14Font;
    [self addSubview:_countDownLabel];
    
    _quickButton = [PLZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = PFR12Font;
    [_quickButton setImage:[UIImage imageNamed:@"shouye_icon_jiantou"] forState:0];
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:0];
    [_quickButton setTitle:@"好货秒抢" forState:0];
    [self addSubview:_quickButton];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _redView.frame = CGRectMake(0, 10, 8, 20);
    _timeLabel.frame = CGRectMake(20, 0, 60, self.pl_height);
    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, 100, self.pl_height);
    _quickButton.frame = CGRectMake(self.pl_width - 70, 0, 70, self.pl_height);
}
@end
