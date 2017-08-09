//
//  PLFeatureItemCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLFeatureItemCell.h"
#import "PLFeatureItem.h"
#import "PLFeatureList.h"

@interface PLFeatureItemCell ()

//属性
@property (nonatomic, strong) UILabel *attLabel;
@end
@implementation PLFeatureItemCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _attLabel = [[UILabel alloc] init];
    _attLabel.textAlignment = NSTextAlignmentCenter;
    _attLabel.font = PFR13Font;
    [self addSubview:_attLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setContent:(PLFeatureList *)content {
    _content = content;
    _attLabel.text = content.infoname;
    
    if (content.isSelect) {
        _attLabel.textColor = [UIColor redColor];
        [PLSpeedy pl_changeControlCircularWith:_attLabel andSetCornerRadius:5 setBorderWidth:1 setBorderColor:[UIColor redColor] canMasksToBounds:YES];
    } else {
        _attLabel.textColor = [UIColor blackColor];
        [PLSpeedy pl_changeControlCircularWith:_attLabel andSetCornerRadius:5 setBorderWidth:1 setBorderColor:[UIColor lightGrayColor] canMasksToBounds:YES];
    }
}
@end
