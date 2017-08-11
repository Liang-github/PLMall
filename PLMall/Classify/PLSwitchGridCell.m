//
//  PLSwitchGridCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLSwitchGridCell.h"
#import "PLRecomendItem.h"
#import <UIImageView+WebCache.h>

@interface PLSwitchGridCell ()

//优惠套装
@property (nonatomic, strong) UIImageView *freeSuitImageView;
//商品图片
@property (nonatomic, strong) UIImageView *gridImageView;
//商品标题
@property (nonatomic, strong) UILabel *gridLabel;
//自营
@property (nonatomic, strong) UIImageView *autotrophyImageView;
//价格
@property (nonatomic, strong) UILabel *priceLabel;
//评价数量
@property (nonatomic, strong) UILabel *commentNumLabel;
@end
@implementation PLSwitchGridCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _freeSuitImageView = [[UIImageView alloc] init];
    _freeSuitImageView.image = [UIImage imageNamed:@"taozhuang_tag"];
    [self addSubview:_freeSuitImageView];
    
    _autotrophyImageView = [[UIImageView alloc] init];
    [self addSubview:_autotrophyImageView];
    _autotrophyImageView.image = [UIImage imageNamed:@"detail_title_ziying_tag"];
    
    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR14Font;
    _gridLabel.numberOfLines = 1;
    [self addSubview:_gridLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR15Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
    
    _commentNumLabel = [[UILabel alloc] init];
    NSInteger pNum = arc4random()%10000;
    _commentNumLabel.text = [NSString stringWithFormat:@"%zd人已评价",pNum];
    _commentNumLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_commentNumLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(self.pl_width*0.8, self.pl_width*0.8));
    }];
    [_autotrophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.top.equalTo(_gridImageView.mas_bottom).offset(PLMargin);
    }];
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(_autotrophyImageView);
        make.right.equalTo(self).offset(-PLMargin);
    }];
    [_freeSuitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_autotrophyImageView);
        make.top.equalTo(_gridLabel.mas_bottom).offset(2);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_autotrophyImageView);
        make.top.equalTo(_freeSuitImageView.mas_bottom).offset(2);
    }];
    [_commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_autotrophyImageView);
        make.top.equalTo(_priceLabel.mas_bottom).offset(2);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setYouSelectItem:(PLRecomendItem *)youSelectItem {
    _youSelectItem = youSelectItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:youSelectItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[youSelectItem.price floatValue]];
    _gridLabel.text = youSelectItem.main_title;
    //首行缩进
    [PLSpeedy pl_setUpLabel:_gridLabel content:youSelectItem.main_title indentationFortheFirstLineWith:_gridLabel.font.pointSize*3.5];
}
@end
