//
//  BaseNavigationController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/3.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "BaseNavigationController.h"
#import "GQGesVCTransition.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
#pragma mark - load初始化一次
+ (void)load {
    [self setUpBase];
}
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [GQGesVCTransition validateGesBackWithType:GQGesVCTransitionTypePanWithPercentRight withRequestFailToLoopScrollView:YES]; //手势返回
}
#pragma mark - <初始化>
+ (void)setUpBase {
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = PLBGColor;
    [bar setShadowImage:[UIImage new]];
    [bar setTintColor:[UIColor clearColor]];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    //设置导航栏字体颜色
    UIColor *navColor = [UIColor blackColor];
    attributes[NSForegroundColorAttributeName] = navColor;
    attributes[NSFontAttributeName] = PFR18Font;
    bar.titleTextAttributes = attributes;
}
#pragma mark - <返回>
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
        //隐藏BottomBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}
#pragma mark - 点击
- (void)backClick {
    [self popViewControllerAnimated:YES];
}
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
@end
