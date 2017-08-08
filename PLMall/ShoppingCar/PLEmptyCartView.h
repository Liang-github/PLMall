//
//  PLEmptyCartView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLEmptyCartView : UIView
//抢购点击回调
@property (nonatomic, copy) dispatch_block_t buyingClickBlock;
@end
