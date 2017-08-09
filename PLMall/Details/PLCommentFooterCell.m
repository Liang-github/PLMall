//
//  PLCommentFooterCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLCommentFooterCell.h"

@interface PLCommentFooterCell ()

//竖分割线
@property (nonatomic, strong) UIView *vLine;

@end
@implementation PLCommentFooterCell

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
    
    _commentFootButton = [PLLIRLButton buttonWithType:UIButtonTypeCustom];
    [_commentFootButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _commentFootButton.titleLabel.font = PFR12Font;
    _commentFootButton.userInteractionEnabled = NO;
    [self addSubview:_commentFootButton];
    
    _vLine = [[UIView alloc] init];
    _vLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.15];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_commentFootButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    if (_isShowLine) {
        [self addSubview:_vLine];
        [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(@1);
            make.height.equalTo(self).multipliedBy(0.6);
        }];
    }
}
@end
