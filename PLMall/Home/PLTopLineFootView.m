//
//  PLTopLineFootView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLTopLineFootView.h"
#import "PLNumericalScrollView.h"
@interface PLTopLineFootView ()<UIScrollViewDelegate, NoticeViewDelegate>
//滚动
@property (nonatomic, strong) PLNumericalScrollView *numericalScrollView;
//底部
@property (nonatomic, strong) UIView *bottomLineView;
@end
@implementation PLTopLineFootView
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self setUpBase];
    }
    return self;
}
- (void)setUpUI {
    NSArray *titles = @[@"CDDMall首单新人礼~",
                        @"github你值得拥有，欢迎点赞~",
                        @"项目持续更新中~"];
    NSArray *btnts = @[@"新人礼",
                       @"github",
                       @"点赞"];
    //初始化
    _numericalScrollView = [[PLNumericalScrollView alloc] initWithFrame:CGRectMake(0, 0, self.pl_width, self.pl_height) andImage:@"shouye_img_toutiao" andDataArray:titles withDataArray:btnts];
    _numericalScrollView.delegate = self;
    //设置定时器多久循环
    _numericalScrollView.interval = 5;
    [self addSubview:_numericalScrollView];
    //开始循环
    [_numericalScrollView startTimer];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = PLBGColor;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.pl_height - 8, ScreenW, 8);
}
- (void)setUpBase {
    self.backgroundColor = [UIColor whiteColor];
}
- (void)noticeViewSelectNoticeActionAtIndex:(NSInteger)index {
    NSLog(@"点击了第%zd头条滚动条",index);
}
@end
