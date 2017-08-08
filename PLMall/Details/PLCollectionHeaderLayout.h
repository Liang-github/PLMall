//
//  PLCollectionHeaderLayout.h
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalCollectionLayoutDelegate <NSObject>

@optional
//用协议传回 item 的内容，用于计算item宽度
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath;
//用协议传回 headerSize 的 size
- (CGSize)collectionViewDynamicHeaderSizeWithIndexPath:(NSIndexPath *)indexPath;
//用协议传回 footerSize 的 size
- (CGSize)collectionViewDynamicFooterSizeWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface PLCollectionHeaderLayout : UICollectionViewFlowLayout
//item的行距
@property (nonatomic, assign) CGFloat lineSpacing;
//item的间距
@property (nonatomic, assign) CGFloat interitemSpacing;
//header高度
@property (nonatomic, assign) CGFloat headerViewHeight;
//footer高度
@property (nonatomic, assign) CGFloat footerViewHeight;
//item高度
@property (nonatomic, assign) CGFloat itemHeight;
//footer边距缩进
@property (nonatomic, assign) UIEdgeInsets footerInset;
//header边距缩进
@property (nonatomic, assign) UIEdgeInsets headerInset;
//item边距缩进
@property (nonatomic, assign) UIEdgeInsets itemInset;
//item Label Font
@property (nonatomic, copy) UIFont *labelFont;
@property (nonatomic, weak) id<HorizontalCollectionLayoutDelegate> delegate;
@end
