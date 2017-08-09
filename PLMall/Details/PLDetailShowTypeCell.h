//
//  PLDetailShowTypeCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLDetailShowTypeCell : UICollectionViewCell

//是否有指示箭头
@property (nonatomic, assign) BOOL isHasindicateButton;
//指示按钮
@property (nonatomic, strong) UIButton *indicateButton;
//标题
@property (nonatomic, strong) UILabel *leftTitleLabel;
//图片
@property (nonatomic, strong) UIImageView *iconImageView;
//内容
@property (nonatomic, strong) UILabel *contentLabel;
//提示
@property (nonatomic, strong) UILabel *hintLabel;
@end
