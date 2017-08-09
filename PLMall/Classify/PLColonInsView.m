//
//  PLColonInsView.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLColonInsView.h"
#import "PLUpDownButton.h"

@interface PLColonInsView ()

//收藏按钮
@property (nonatomic, strong) UIButton *collectButton;
//加入购物车按钮
@property (nonatomic, strong) UIButton *addShopCarButton;
@end

@implementation PLColonInsView
#pragma mark - Intial
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_collectButton];
    _collectButton.tag = 0;
    _collectButton.backgroundColor = [UIColor orangeColor];
    [_collectButton setImage:[UIImage imageNamed:@"search_list_collect_icon"] forState:UIControlStateNormal];
    _collectButton.frame = CGRectMake(self.pl_width - 80, 0, 80, self.pl_height*0.5);
    [_collectButton addTarget:self action:@selector(setUpClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _addShopCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_addShopCarButton];
    _addShopCarButton.tag = 1;
    _addShopCarButton.backgroundColor = [UIColor redColor];
    [_addShopCarButton setImage:[UIImage imageNamed:@"search_list_addcart_icon"] forState:UIControlStateNormal];
    _addShopCarButton.frame = CGRectMake(self.pl_width - 80, self.pl_height*0.5, 80, self.pl_height*0.5);
    [_addShopCarButton addTarget:self action:@selector(setUpClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *titles = @[@"同品牌",@"同价位"];
    NSArray *images = @[@"search_list_samebrand_icon",@"search_list_sameprice_icon"];
    CGFloat buttonX = (self.pl_width - _addShopCarButton.pl_width)/2;
    CGFloat buttonW = 50;
    CGFloat buttonH = self.pl_height*0.5;
    
    for (NSInteger i = 0; i < images.count; i ++) {
        PLUpDownButton *button = [PLUpDownButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        CGFloat buttonY = i*buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = i + 2;
        [button addTarget:self action:@selector(setUpClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
#pragma mark - Setter Getter Methods
- (void)setUpClickAction:(UIButton *)button {
    if (button.tag == 0) {
        !_collectionBlock ? : _collectionBlock();
    } else if (button.tag == 1) {
        !_addShopCarBlock ? : _addShopCarBlock();
    } else if (button.tag == 2) {
        !_sameBrandBlock ? : _sameBrandBlock();
    } else if (button.tag == 3) {
        !_samePriceBlock ? : _samePriceBlock();
    }
}

@end
