//
//  PLGoodsGridCell.m
//  
//
//  Created by PengLiang on 2017/8/11.
//
//

#import "PLGoodsGridCell.h"
#import "PLGridItem.h"
#import <UIImageView+WebCache.h>

@interface PLGoodsGridCell ()

@property (nonatomic, strong) UIImageView *gridImageView;
@property (nonatomic, strong) UILabel *gridLabel;
@end
@implementation PLGoodsGridCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR13Font;
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(PLMargin);
        if (iphone5) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
        } else {
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }
        make.centerX.equalTo(self);
    }];
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_gridImageView.mas_bottom).offset(5);
    }];
}
- (void)setGridItem:(PLGridItem *)gridItem {
    _gridItem = gridItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]];
    _gridLabel.text = gridItem.gridTitle;
}
@end
