//
//  PLCommentPicCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLCommentPicItem;
@interface PLCommentPicCell : UICollectionViewCell
//图片评论
@property (nonatomic, strong) PLCommentPicItem *picItem;
//图片
@property (nonatomic, strong) UIImageView *picIamgeView;
@end
