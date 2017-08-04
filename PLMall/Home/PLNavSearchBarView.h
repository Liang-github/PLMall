//
//  PLNavSearchBarView.h
//  PLMall
//
//  Created by PengLiang on 2017/8/4.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLNavSearchBarView : UIView

//语音按钮
@property (nonatomic, strong) UIButton *voiceImageBtn;
//占位文字
@property (nonatomic, strong) UILabel *placeholdLabel;
//语音点击回调Block
@property (nonatomic, copy) dispatch_block_t voiceButtonClickBlock;
//搜索
@property (nonatomic, copy) dispatch_block_t searchViewBlock;
@end
