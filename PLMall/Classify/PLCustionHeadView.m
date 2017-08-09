//
//  PLCustionHeadView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#define AuxiliaryNum 100
#import "PLCustionHeadView.h"
#import "PLCustionButton.h"

@interface PLCustionHeadView ()
//记录上一次选中的button
@property (nonatomic, weak) PLCustionButton *selectBtn;
//记录上一次选中的Button底部View
@property (nonatomic, strong) UIView *selectBottomRedView;
@end
@implementation PLCustionHeadView
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
    NSArray *titles = @[@"推荐",@"价格",@"销量",@"筛选"];
    NSArray *noImage = @[@"icon_Arrow2",@"",@"",@"icon_shaixuan"];
    CGFloat btnW = self.pl_width/titles.count;
    CGFloat btnH = self.pl_height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < titles.count; i ++) {
        PLCustionButton *button = [PLCustionButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [self addSubview:button];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:noImage[i]] forState:UIControlStateNormal];
        button.tag = i + AuxiliaryNum;
        
        CGFloat btnX = i*btnW;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self buttonClick:button]; //默认选择第一个
        }
    }
    [PLSpeedy pl_setUpAcrossPartingLineWith:self withColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]];
}
#pragma mark - 按钮点击
- (void)buttonClick:(PLCustionButton *)button {
    if (button.tag == 3 + AuxiliaryNum) {
        !_filtrateClickBlock ? : _filtrateClickBlock();
    } else {
        _selectBottomRedView.hidden = YES;
        [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        UIView *bottomRedView = [[UIView alloc] init];
        [self addSubview:bottomRedView];
        bottomRedView.backgroundColor = [UIColor redColor];
        bottomRedView.pl_width = button.pl_width;
        bottomRedView.pl_height = 3;
        bottomRedView.pl_y = button.pl_height - bottomRedView.pl_height;
        bottomRedView.pl_x = button.pl_x;
        bottomRedView.hidden = NO;
        
        _selectBtn = button;
        _selectBottomRedView = bottomRedView;
    }
}
@end
