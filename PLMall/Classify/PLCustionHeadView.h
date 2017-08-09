//
//  PLCustionHeadView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLCustionHeadView : UICollectionReusableView
//筛选点击回调
@property (nonatomic, copy) dispatch_block_t filtrateClickBlock;
@end
