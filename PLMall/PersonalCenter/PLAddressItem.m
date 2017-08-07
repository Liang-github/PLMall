//
//  PLAddressItem.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLAddressItem.h"

@implementation PLAddressItem

- (CGFloat)cellHeight {
    if (_cellHeight) {
        return _cellHeight;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@",_adCity,_adDetail];
    CGSize titleSize = [PLSpeedy pl_calculateTextSizeWithText:str withTextFont:13 withMaxW:ScreenW - 4*PLMargin];
    _cellHeight = 4*PLMargin + titleSize.height + 35 + 30;
    return _cellHeight;
}
@end
