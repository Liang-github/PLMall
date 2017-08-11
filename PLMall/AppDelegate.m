//
//  AppDelegate.m
//  PLMall
//
//  Created by PengLiang on 2017/8/3.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "AppDelegate.h"
#import "JKDBModel.h"
#import "BaseTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[BaseTabBarController alloc] init];
    [self setUpUserData]; //设置数据
    return YES;
}
//是否登录
- (void)setUpUserData {
    PLUserInfo *userInfo = UserInfoData;
    if (userInfo.username.length == 0) { //userName为指定id不可改动用来判断是否有用户数据
        PLUserInfo *userInfo = [[PLUserInfo alloc] init];
        userInfo.nickname = @"shifu";
        userInfo.sex = @"男";
        userInfo.birthDay = @"1994-08-18";
        userInfo.userimage = @"icon";
        userInfo.username = @"冬like";
        userInfo.defaultAddress = @"南京 玄武区";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //异步保存
            [userInfo save];
        });
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
