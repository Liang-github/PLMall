//
//  PLHoverNavView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLHoverNavView : UIView
//title
@property (nonatomic, strong) UILabel *titleLabel;
//imageView
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, copy) void(^leftItemClickBlock)();
@property (nonatomic, copy) void(^rightItemCickBlock)();
@end
