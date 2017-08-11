//
//  PLYouLikeHeadView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLYouLikeHeadView.h"

@implementation PLYouLikeHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _likeButton = [PLLIRLButton buttonWithType:UIButtonTypeCustom];
    _likeButton.titleLabel.font = PFR13Font;
    [self addSubview:_likeButton];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
@end
