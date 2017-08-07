//
//  PLMessageNoteCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLMessageNoteCell.h"
#import "PLMessageItem.h"

@interface PLMessageNoteCell ()
//标题Label
@property (nonatomic, strong) UILabel *titleLabel;
//图片
@property (nonatomic, strong) UIImageView *imageNameView;
//消息
@property (nonatomic, strong) UILabel *messageLabel;
//底部分割线
@property (nonatomic, strong) UIView *cellLine;

@end
@implementation PLMessageNoteCell
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
    _titleLabel.font = PFR14Font;
    [self addSubview:_titleLabel];
    
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = PFR13Font;
    _messageLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_messageLabel];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
    _cellLine = [[UIView alloc] init];
    _cellLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:_cellLine];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PLMargin);
        make.top.mas_equalTo(self).offset(PLMargin);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(64);
        make.right.mas_equalTo(self).offset(-PLMargin);
        make.top.mas_equalTo(self).offset(PLMargin);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(self.mas_right).offset(PLMargin);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
    }];
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}
#pragma mark - Setter Getter Methods
- (void)setMessageItem:(PLMessageItem *)messageItem {
    _messageItem = messageItem;
    self.titleLabel.text = messageItem.title;
    self.imageNameView.image = [UIImage imageNamed:messageItem.imageName];
    self.messageLabel.text = messageItem.message;
}
@end
