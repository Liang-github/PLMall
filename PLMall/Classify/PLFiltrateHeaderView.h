//
//  PLFiltrateHeaderView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLFiltrateHeaderView : UICollectionReusableView

@property (nonatomic, copy) NSString *title;
//头部点击
@property (nonatomic, copy) dispatch_block_t sectionClick;
@end
