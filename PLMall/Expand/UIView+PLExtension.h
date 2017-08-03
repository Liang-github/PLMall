//
//  UIView+PLExtension.h
//  PLMall
//
//  Created by PengLiang on 2017/8/3.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PLExtension)

@property (nonatomic, assign) CGFloat pl_width;
@property (nonatomic, assign) CGFloat pl_height;
@property (nonatomic, assign) CGSize pl_size;
@property (nonatomic, assign) CGFloat pl_x;
@property (nonatomic, assign) CGFloat pl_y;
@property (nonatomic, assign) CGPoint pl_origin;
@property (nonatomic, assign) CGFloat pl_centerX;
@property (nonatomic, assign) CGFloat pl_centerY;
@property (nonatomic, assign) CGFloat pl_right;
@property (nonatomic, assign) CGFloat pl_bottom;

- (BOOL)intersectWithView:(UIView *)view;
+ (instancetype)pl_viewFromXib;
- (BOOL)isShowingOnKeyWindow;
@end
