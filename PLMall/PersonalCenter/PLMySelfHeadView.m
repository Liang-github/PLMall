//
//  PLMySelfHeadView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLMySelfHeadView.h"

@implementation PLMySelfHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [PLSpeedy pl_setUpBezierPathCircularLayerWith:_headImageButton withSize:CGSizeMake(self.headImageButton.pl_width*0.5, self.headImageButton.pl_width*0.5)];
}

#pragma mark - 点击事件
- (IBAction)goodsCollectionClick {
    !_goodsCollectionClickBlock ? : _goodsCollectionClickBlock();
}
- (IBAction)shopCollectionClick {
    !_shopCollectionClickBlock ? : _shopCollectionClickBlock();
}
- (IBAction)myFootprintClick {
    !_myFootprintClickBlock ? : _myFootprintClickBlock();
}
- (IBAction)mySideClick {
    !_mySideClickBlock ? : _mySideClickBlock();
}
- (IBAction)imageButtonClick {
    !_myHeadImageViewClickBlock ? : _myHeadImageViewClickBlock();
}

@end
