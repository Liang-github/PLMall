//
//  PLGoodsHandheldCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLGoodsHandheldCell.h"
#import <UIImageView+WebCache.h>

@interface PLGoodsHandheldCell ()
//图片
@property (nonatomic, strong) UIImageView *handheldImageView;
@end
@implementation PLGoodsHandheldCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _handheldImageView = [[UIImageView alloc] init];
    _handheldImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_handheldImageView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_handheldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)setHandheldImage:(NSString *)handheldImage {
    _handheldImage = handheldImage;
    
    [_handheldImageView sd_setImageWithURL:[NSURL URLWithString:handheldImage]];
}
@end
