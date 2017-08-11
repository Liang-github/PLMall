//
//  PLListGridCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/10.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLListGridCell.h"
#import "PLRecomendItem.h"
#import <UIImageView+WebCache.h>

@interface PLListGridCell ()

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
//冒号
@property (nonatomic, strong) UIButton *colonButton;
@end
@implementation PLListGridCell
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
    _gridLabel.numberOfLines = 2;
    _gridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_gridLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR15Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
    
    _commentNumLabel = [[UILabel alloc] init];
    NSInteger pNum = arc4random()%10000;
    _commentNumLabel.text = [NSString stringWithFormat:@"%zd人已评价",pNum];
    _commentNumLabel.font = PFR10Font;
    _commentNumLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_commentNumLabel];
    
    _colonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_colonButton setImage:[UIImage imageNamed:@"icon_shenglue"] forState:UIControlStateNormal];
    [_colonButton addTarget:self action:@selector(colonButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_colonButton];
    
    [PLSpeedy pl_setUpAcrossPartingLineWith:self withColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.4]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(PLMargin*2);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    [_autotrophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridImageView.mas_right).offset(PLMargin);
        make.top.equalTo(_gridImageView);
    }];
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gridImageView.mas_right).offset(PLMargin);
        make.top.equalTo(_gridImageView).offset(-3);
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
    [_colonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-PLMargin);
        make.bottom.equalTo(self).offset(-PLMargin);
        make.size.mas_equalTo(CGSizeMake(22, 15));
    }];
}
#pragma mark - Setter Getter Methods
- (void)setYouSelectItem:(PLRecomendItem *)youSelectItem {
    _youSelectItem = youSelectItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:youSelectItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[youSelectItem.price floatValue]];
    _gridLabel.text = youSelectItem.main_title;
    //首行缩进
    [PLSpeedy pl_setUpLabel:_gridLabel content:youSelectItem.main_title indentationFortheFirstLineWith:_gridLabel.font.pointSize*2.5];
}
#pragma mark - 点击事件
- (void)colonButtonClick {
    !_colonClickBlock ? : _colonClickBlock();
}
@end
