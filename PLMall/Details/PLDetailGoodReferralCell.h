//
//  PLDetailGoodReferralCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLDetailGoodReferralCell : UICollectionViewCell

//商品标题
@property (nonatomic, strong) UILabel *goodTitleLabel;
//商品价格
@property (nonatomic, strong) UILabel *goodPriceLabel;
//商品小标题
@property (nonatomic, strong) UILabel *goodSubtitleLabel;
//优惠按钮
@property (nonatomic, strong) UIButton *preferentialButton;
//分享按钮点击回调
@property (nonatomic, copy) dispatch_block_t shareButtonClickBlock;
@end
