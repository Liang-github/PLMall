//
//  PLCommentFooterCell.h
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLLIRLButton.h"

@interface PLCommentFooterCell : UICollectionViewCell

//全部 购买按钮
@property (nonatomic, strong) PLLIRLButton *commentFootButton;
//分割线
@property (nonatomic, assign) BOOL isShowLine;
@end
