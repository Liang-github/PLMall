//
//  PLMySelfHeadView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLMySelfHeadView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *headImageButton;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
//商品收藏点击事件
@property (nonatomic, copy) dispatch_block_t goodsCollectionClickBlock;
//店铺收藏点击事件
@property (nonatomic, copy) dispatch_block_t shopCollectionClickBlock;
//我的足迹点击事件
@property (nonatomic, copy) dispatch_block_t myFootprintClickBlock;
//身边点击事件
@property (nonatomic, copy) dispatch_block_t mySideClickBlock;
//头像点击事件
@property (nonatomic, copy) dispatch_block_t myHeadImageViewClickBlock;
@end
