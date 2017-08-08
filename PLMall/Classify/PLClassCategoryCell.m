//
//  PLClassCategoryCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLClassCategoryCell.h"
#import "PLClassGoodsItem.h"
@interface PLClassCategoryCell ()
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//指示View
@property (nonatomic, strong) UIView *indicatorView;

@end
@implementation PLClassCategoryCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
        self.selectionStyle = 0;
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR15Font;
    [self addSubview:_titleLabel];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.hidden = NO;
    _indicatorView.backgroundColor = [UIColor redColor];
    [self addSubview:_indicatorView];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(@5);
    }];
}
#pragma mark - cell点击
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _indicatorView.hidden = NO;
        _titleLabel.textColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
    } else {
        _indicatorView.hidden = YES;
        _titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark - Setter Getter Methods
- (void)setTitleItem:(PLClassGoodsItem *)titleItem {
    _titleItem = titleItem;
    self.titleLabel.text = titleItem.title;
}
@end
