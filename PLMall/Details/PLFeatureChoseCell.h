//
//  PLFeatureChoseCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLFeatureChoseCell : UITableViewCell
//取消点击回调
@property (nonatomic, copy) dispatch_block_t crossButtonClickBlock;
//商品价格
@property (nonatomic, strong) UILabel *goodPriceLabel;
//图片
@property (nonatomic, strong) UIImageView *goodImageView;
//选择属性
@property (nonatomic, strong) UILabel *chooseAttLabel;
@end
