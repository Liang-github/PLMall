//
//  PLDetailOverFooterView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailOverFooterView.h"
#import "PLLIRLButton.h"

@interface PLDetailOverFooterView ()
//底部上拉提示
@property (nonatomic, strong) PLLIRLButton *overMarkButton;
@end
@implementation PLDetailOverFooterView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = PLBGColor;
    _overMarkButton = [PLLIRLButton buttonWithType:UIButtonTypeCustom];
    [_overMarkButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:UIControlStateNormal];
    [_overMarkButton setTitle:@"上拉查看图文详情" forState:UIControlStateNormal];
    _overMarkButton.titleLabel.font = PFR12Font;
    [_overMarkButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:_overMarkButton];
    
    _overMarkButton.frame = CGRectMake(0, 0, self.pl_width, self.pl_height);
}
@end
