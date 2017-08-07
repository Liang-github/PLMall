//
//  PLFlowAttributeCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLFlowItem;

typedef enum : NSUInteger {
    PLFlowTypeImage = 0,
    PLFlowTypeLabel = 1,
} PLFlowType;

@interface PLFlowAttributeCell : UICollectionViewCell

//图片
@property (nonatomic, strong) UIImageView *flowImageView;
//名字
@property (nonatomic, strong) UILabel *flowTextLabel;
//数字
@property (nonatomic, strong) UILabel *flowNumLabel;
//属性type
@property (nonatomic, assign) PLFlowType type;
//数据
@property (nonatomic, strong) PLFlowItem *flowItem;
//最后一个按钮是图片判断
@property (nonatomic, assign) BOOL lastIsImageView;
@end
