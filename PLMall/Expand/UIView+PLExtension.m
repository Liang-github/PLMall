//
//  UIView+PLExtension.m
//  PLMall
//
//  Created by PengLiang on 2017/8/3.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "UIView+PLExtension.h"

@implementation UIView (PLExtension)

- (CGFloat)pl_x {
    return self.frame.origin.x;
}
- (void)setPl_x:(CGFloat)pl_x {
    CGRect frame = self.frame;
    frame.origin.x = pl_x;
    self.frame = frame;
}
- (CGFloat)pl_y {
    return self.frame.origin.y;
}
- (void)setPl_y:(CGFloat)pl_y {
    CGRect frame = self.frame;
    frame.origin.y = pl_y;
    self.frame = frame;
}
- (CGPoint)pl_origin {
    return self.frame.origin;
}
- (void)setPl_origin:(CGPoint)pl_origin {
    CGRect frame = self.frame;
    frame.origin = pl_origin;
    self.frame = frame;
}
- (CGFloat)pl_width {
    return self.frame.size.width;
}
- (void)setPl_width:(CGFloat)pl_width {
    CGRect frame = self.frame;
    frame.size.width = pl_width;
    self.frame = frame;
}
- (CGFloat)pl_height {
    return self.frame.size.height;
}
- (void)setPl_height:(CGFloat)pl_height {
    CGRect frame = self.frame;
    frame.size.height = pl_height;
    self.frame = frame;
}
- (CGSize)pl_size {
    return self.frame.size;
}
- (void)setPl_size:(CGSize)pl_size {
    CGRect frame = self.frame;
    frame.size = pl_size;
    self.frame = frame;
}
- (CGFloat)pl_centerX {
    return self.center.x;
}
- (void)setPl_centerX:(CGFloat)pl_centerX {
    CGPoint point = self.center;
    point.x = pl_centerX;
    self.center = point;
}
- (CGFloat)pl_centerY {
    return self.center.y;
}
- (void)setPl_centerY:(CGFloat)pl_centerY {
    CGPoint point = self.center;
    point.y = pl_centerY;
    self.center = point;
}
- (CGFloat)pl_right {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)pl_bottom {
    return CGRectGetMaxY(self.frame);
}
- (void)setPl_right:(CGFloat)pl_right {
    self.pl_x = pl_right = self.pl_width;
}
- (void)setPl_bottom:(CGFloat)pl_bottom {
    self.pl_y = pl_bottom - self.pl_height;
}
- (BOOL)intersectWithView:(UIView *)view {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}
- (BOOL)isShowingOnKeyWindow {
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //以主窗口左上角为坐标原点，计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame toView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    //主窗口的bounds和self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
                           
}
+ (instancetype)pl_viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
