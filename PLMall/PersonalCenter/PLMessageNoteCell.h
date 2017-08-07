//
//  PLMessageNoteCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PLMessageItem;

@interface PLMessageNoteCell : UITableViewCell
//消息模型
@property (nonatomic, strong) PLMessageItem *messageItem;
@end
