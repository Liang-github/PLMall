//
//  PLGoodDetailViewController.h
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLGoodDetailViewController : UIViewController

//商品标题
@property (nonatomic, strong) NSString *goodTitle;
//商品价格
@property (nonatomic, strong) NSString *goodPrice;
//商品小标题
@property (nonatomic, strong) NSString *goodSubTitle;
//商品图片
@property (nonatomic, strong) NSString *goodImageView;
//商品轮播图
@property (nonatomic, strong) NSArray *shufflingArray;
@end
