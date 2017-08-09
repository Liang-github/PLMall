//
//  PLDetailServicetCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLLIRLButton.h"

@interface PLDetailServicetCell : UICollectionViewCell
//服务按钮
@property (nonatomic, strong) PLLIRLButton *serviceButton;
//服务标题
@property (nonatomic, strong) UILabel *serviceLabel;
@end
