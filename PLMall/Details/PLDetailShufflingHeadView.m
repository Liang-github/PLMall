//
//  PLDetailShufflingHeadView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLDetailShufflingHeadView.h"
#import <SDCycleScrollView.h>

@interface PLDetailShufflingHeadView ()<SDCycleScrollViewDelegate>

//轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end
@implementation PLDetailShufflingHeadView

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
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, self.pl_height) delegate:self placeholderImage:nil];
    _cycleScrollView.autoScroll = NO; //不自动滚动
    [self addSubview:_cycleScrollView];
}
#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}
#pragma mark - Setter Getter Methods
- (void)setShufflingArray:(NSArray *)shufflingArray {
    _shufflingArray = shufflingArray;
    _cycleScrollView.imageURLStringsGroup = shufflingArray;
}
@end
