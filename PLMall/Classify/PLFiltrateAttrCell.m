//
//  PLFiltrateAttrCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLFiltrateAttrCell.h"
#import "PLFiltrateItem.h"

@interface PLFiltrateAttrCell ()

//属性
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation PLFiltrateAttrCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = RGB(240, 240, 240);
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.font = PFR12Font;
    [self addSubview:_contentLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
#pragma mark - cell点击
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        _contentLabel.textColor = [UIColor redColor];
        [PLSpeedy pl_changeControlCircularWith:self andSetCornerRadius:0 setBorderWidth:1 setBorderColor:[UIColor redColor] canMasksToBounds:YES];
        self.backgroundColor = [UIColor whiteColor];
    } else {
        [PLSpeedy pl_changeControlCircularWith:self andSetCornerRadius:0 setBorderWidth:1 setBorderColor:[UIColor clearColor] canMasksToBounds:YES];
        _contentLabel.textColor = [UIColor darkGrayColor];
        self.backgroundColor = RGB(240, 240, 240);
    }
}
#pragma mark - Setter Getter Methods
- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
}
@end
