//
//  PLColonInsView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLColonInsView : UIView

#pragma mark - 初始化
- (void)setUpUI;

//收藏回调
@property (nonatomic, copy) dispatch_block_t collectionBlock;
//加入购物车回调
@property (nonatomic, copy) dispatch_block_t addShopCarBlock;
@property (nonatomic, copy) dispatch_block_t sameBrandBlock;
@property (nonatomic, copy) dispatch_block_t samePriceBlock;
@end
