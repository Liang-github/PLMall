//
//  PLKeepNewUserData.m
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLKeepNewUserData.h"

@implementation PLKeepNewUserData

+ (void)keepNewDidFinished:(void (^)(PLUserInfo *))theNewData {
    __block PLUserInfo *userInfo = UserInfoData;
    
    [PLUserInfo deleteObjects:[PLUserInfo findAll]];
    [userInfo save];
    !theNewData ? : theNewData(userInfo);
}
@end
