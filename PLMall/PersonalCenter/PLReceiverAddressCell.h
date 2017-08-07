//
//  PLReceiverAddressCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLAddressItem;

@interface PLReceiverAddressCell : UITableViewCell

//地址数组
@property (nonatomic, strong) PLAddressItem *adItem;
//默认地址点击回调
@property (nonatomic, copy) dispatch_block_t defaultClickBlock;
//编辑点击回调
@property (nonatomic, copy) dispatch_block_t editClickBlock;
//删除点击回调
@property (nonatomic, copy) dispatch_block_t delectClickBlock;
@end
