//
//  PLSettingCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, cellType) {
    cellTypeOne   = 0,
    cellTypeTwo   = 1,
    cellTypeThree = 2
};

@interface PLSettingCell : UITableViewCell

//title
@property (nonatomic, strong) UILabel *titleLabel;
//UISwitch
@property (nonatomic, strong) UISwitch *setSwitch;
//指示按钮
@property (nonatomic, strong) UIButton *indicateButton;
//内容
@property (nonatomic, strong) UILabel *contentLabel;
//日期
@property (nonatomic, strong) UITextField *birthField;
//cell类型
@property (nonatomic, assign) cellType type;

@end
