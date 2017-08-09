//
//  PLCommentHeaderCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLCommentHeaderCell.h"

@interface PLCommentHeaderCell ()
//指示按钮
@property (nonatomic, strong) UIButton *indicateButton;
//评价数量
@property (nonatomic, strong) UILabel *commentNumLabel;
//好评比
@property (nonatomic, strong) UILabel *goodCommentPLabel;

@end
@implementation PLCommentHeaderCell

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
    _commentNumLabel = [[UILabel alloc] init];
    _commentNumLabel.font = PFR13Font;
    [self addSubview:_commentNumLabel];
    
    _indicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
    [self addSubview:_indicateButton];
    
    _goodCommentPLabel = [[UILabel alloc] init];
    _goodCommentPLabel.font = PFR12Font;
    [self addSubview:_goodCommentPLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.centerY.equalTo(self);
    }];
    [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-PLMargin);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(self);
    }];
    [_goodCommentPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_indicateButton.mas_left).offset(-2);
        make.centerY.equalTo(self);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setComNum:(NSString *)comNum {
    _comNum = comNum;
    _commentNumLabel.text = [NSString stringWithFormat:@"评论(%@)",comNum];
}
- (void)setWellPer:(NSString *)wellPer {
    _wellPer = wellPer;
    _goodCommentPLabel.text = [NSString stringWithFormat:@"好评度：%@",wellPer];
    [PLSpeedy pl_setSomeOneChangeColor:_goodCommentPLabel setSelectArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"%"] setChangeColor:[UIColor redColor]];
}
@end
