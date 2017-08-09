//
//  PLDetailCustomHeadView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailCustomHeadView.h"

@interface PLDetailCustomHeadView ()
//猜你喜欢
@property (nonatomic, strong) UILabel *guessMarkLabel;
@end

@implementation PLDetailCustomHeadView

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
    
    _guessMarkLabel = [[UILabel alloc] init];
    _guessMarkLabel.text = @"猜你喜欢";
    _guessMarkLabel.font = PFR15Font;
    [self addSubview:_guessMarkLabel];
    
    _guessMarkLabel.frame = CGRectMake(PLMargin, 0, 200, self.pl_height);
}
@end
