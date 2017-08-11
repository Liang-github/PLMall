//
//  PLFeatureSelectionViewController.h
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLFeatureSelectionViewController : UIViewController
//商品图片
@property (nonatomic, strong) NSString *goodImageView;
//上一次选择的属性
@property (nonatomic, strong) NSArray *lastSeleArray;
//上一次选择的数量
@property (nonatomic, assign) NSInteger lastNum;
//选择的属性和数量
@property (nonatomic, copy) void(^userChooseBlock)(NSMutableArray *seleArray,NSInteger num,NSInteger tag);
@end
