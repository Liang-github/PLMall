//
//  PLNumericalScrollView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoticeViewDelegate <NSObject>

- (void)noticeViewSelectNoticeActionAtIndex:(NSInteger)index;

@end
@interface PLNumericalScrollView : UIView
//图片
@property (nonatomic, strong) UIImageView *imageView;
//定时器的循环时间
@property (nonatomic, assign) NSInteger interval;
@property (nonatomic, assign) id<NoticeViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)imageName andDataArray:(NSArray *)titlesArray withDataArray:(NSArray *)imagesTitlesArray;
//创建定时器并run
- (void)startTimer;
@end
