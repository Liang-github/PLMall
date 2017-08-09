//
//  PLCommentPicCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/9.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLCommentPicCell.h"
#import "PLCommentPicItem.h"
#import "SDPhotoBrowser.h"
#import <UIImageView+WebCache.h>

@interface PLCommentPicCell ()<SDPhotoBrowserDelegate>
//昵称
@property (nonatomic, strong) UILabel *nickname;
//图片数量
@property (nonatomic, strong) UILabel *picNum;
//imageArray
@property (nonatomic, strong) NSArray *imagesArray;
@end
@implementation PLCommentPicCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    
    _picIamgeView = [[UIImageView alloc] init];
    _picIamgeView.contentMode = UIViewContentModeScaleAspectFit;
    _picIamgeView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    [_picIamgeView addGestureRecognizer:tap];
    [self addSubview:_picIamgeView];
    
    _nickname = [[UILabel alloc] init];
    _nickname.font = PFR11Font;
    [self addSubview:_nickname];
    
    _picNum = [[UILabel alloc] init];
    _picNum.textColor = [UIColor whiteColor];
    _picNum.backgroundColor = RGB(60, 53, 44);
    _picNum.textAlignment = NSTextAlignmentCenter;
    _picNum.font = PFR10Font;
    [self addSubview:_picNum];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_picIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(2);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [_picNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_picIamgeView);
        make.bottom.equalTo(_picIamgeView);
        make.size.mas_equalTo(CGSizeMake(30, 18));
    }];
    [_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picIamgeView.mas_bottom).offset(2);
        make.left.equalTo(_picIamgeView);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setPicItem:(PLCommentPicItem *)picItem {
    _picItem = picItem;
    
    [_picIamgeView sd_setImageWithURL:[NSURL URLWithString:picItem.images[0]]];
    _picNum.text = [NSString stringWithFormat:@"%zd张",picItem.images.count];
    _nickname.text = [PLSpeedy pl_encryptionDisplayMessageWith:picItem.nickname withFirstIndex:2];
    _imagesArray = picItem.images;
}
#pragma mark - 图片点击
- (void)tapImageView {
    SDPhotoBrowser *brower = [[SDPhotoBrowser alloc] init];
    brower.currentImageIndex = 0;
    brower.sourceImagesContainerView = self;
    brower.isCascadingShow = YES; //层叠
    brower.imageCount = _imagesArray.count;
    brower.delegate = self;
    [brower show];
}
#pragma mark - SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSURL *url = [NSURL new];
    if (index < _imagesArray.count) {
        url = [NSURL URLWithString:_imagesArray[index]];
    }
    return url;
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return _picIamgeView.image;
}
@end
