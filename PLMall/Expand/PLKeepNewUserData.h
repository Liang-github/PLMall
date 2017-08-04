//
//  PLKeepNewUserData.h
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLKeepNewUserData : NSObject
+ (void)keepNewDidFinished : (void(^)(PLUserInfo *userInfo))theNewData;
@end
