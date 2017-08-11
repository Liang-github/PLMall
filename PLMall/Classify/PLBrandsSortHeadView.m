//
//  PLBrandsSortHeadView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLBrandsSortHeadView.h"
#import "PLClassMainItem.h"
@interface PLBrandsSortHeadView ()
//头部标题Label
@property (nonatomic, strong) UILabel *headLabel;
@end
@implementation PLBrandsSortHeadView

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
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = PFR13Font;
    _headLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_headLabel];
    
    _headLabel.frame = CGRectMake(PLMargin, 0, self.pl_width, self.pl_height);
}
#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(PLClassMainItem *)headTitle {
    _headTitle = headTitle;
    _headLabel.text = headTitle.title;
}
@end
