//
//  PLReceiverAddressCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLReceiverAddressCell.h"
#import "PLAddressItem.h"

@interface PLReceiverAddressCell ()
//收件人名称
@property (nonatomic, strong) UILabel *adNameLabel;
//收件人电话
@property (nonatomic, strong) UILabel *adPhoneLabel;
//收件人详细地址
@property (nonatomic, strong) UILabel *adDetailLabel;
//默认地址
@property (nonatomic, strong) UIButton *defaultAddressButton;
//编辑
@property (nonatomic, strong) UIButton *editButton;
//删除
@property (nonatomic, strong) UIButton *deleteButton;
//分割线
@property (nonatomic, strong) UIView *partingLine;
//竖分割线
@property (nonatomic, strong) UIView *verticalLine;

@end
@implementation PLReceiverAddressCell
#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.selectionStyle = 0;
    self.backgroundColor = [UIColor whiteColor];
    
    _adNameLabel = [[UILabel alloc] init];
    _adNameLabel.font = PFR15Font;
    [self addSubview:_adNameLabel];
    
    _adPhoneLabel = [[UILabel alloc] init];
    _adPhoneLabel.font = _adNameLabel.font;
    [self addSubview:_adPhoneLabel];
    
    _adDetailLabel = [[UILabel alloc] init];
    _adDetailLabel.font = PFR13Font;
    _adDetailLabel.numberOfLines = 0;
    _adDetailLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_adDetailLabel];
    
    _partingLine = [[UIView alloc] init];
    _partingLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    [self addSubview:_partingLine];
    
    _defaultAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_defaultAddressButton setTitle:@"默认地址" forState:UIControlStateNormal];
    _defaultAddressButton.titleLabel.font = PFR13Font;
    [_defaultAddressButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_defaultAddressButton setImage:[UIImage imageNamed:@"fix_user_address_moren"] forState:UIControlStateNormal];
    [_defaultAddressButton setImage:[UIImage imageNamed:@"fix_user_address_moren_check"] forState:UIControlStateSelected];
    [self addSubview:_defaultAddressButton];
    [_defaultAddressButton addTarget:self action:@selector(defaultAddressButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    _editButton.titleLabel.font = PFR13Font;
    [_editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_editButton setImage:[UIImage imageNamed:@"Address_bianji"] forState:UIControlStateNormal];
    [self addSubview:_editButton];
    [_editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteButton = [[UIButton alloc] init];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    _deleteButton.titleLabel.font = PFR13Font;
    [_deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_deleteButton setImage:[UIImage imageNamed:@"Address_shanchu"] forState:UIControlStateNormal];
    [self addSubview:_deleteButton];
    [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _verticalLine = [[UIView alloc] init];
    _verticalLine.backgroundColor = _partingLine.backgroundColor;
    [self addSubview:_verticalLine];
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= PLMargin;
    frame.origin.y += PLMargin;
    
    frame.origin.x += PLMargin;
    frame.size.width -= 2*PLMargin;
    
    [super setFrame:frame];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_adNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PLMargin);
        make.top.mas_equalTo(self).offset(PLMargin);
        make.height.mas_equalTo(30);
    }];
    
    [_adPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_adNameLabel.mas_right).offset(PLMargin*2);
        make.centerY.mas_equalTo(_adNameLabel);
    }];
    [_adDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_adNameLabel);
        make.right.mas_equalTo(self).offset(-PLMargin);
        make.top.mas_equalTo(_adNameLabel.mas_bottom).offset(PLMargin);
    }];
    [_partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.top.mas_equalTo(_adDetailLabel.mas_bottom).offset(PLMargin);
        make.height.mas_equalTo(1);
    }];
    [_defaultAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(PLMargin);
        make.height.mas_equalTo(35);
    }];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-PLMargin);
        make.height.mas_equalTo(35);
    }];
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_deleteButton);
        make.right.mas_equalTo(_deleteButton.mas_left).offset(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
    }];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(_verticalLine.mas_left).offset(-5);
        make.height.mas_equalTo(35);
    }];
}
#pragma mark - 点击事件
- (void)defaultAddressButtonSelect:(UIButton *)button
{
    button.selected = !button.selected;
    if (!button.selected) {
        !_defaultClickBlock ? : _defaultClickBlock();
    }
}
- (void)editButtonClick
{
    !_editClickBlock ? : _editClickBlock();
}
- (void)deleteButtonClick
{
    !_delectClickBlock ? : _delectClickBlock();
}
#pragma mark - Setter Getter Methods
- (void)setAdItem:(PLAddressItem *)adItem {
    _adItem = adItem;
    _adNameLabel.text = adItem.adName;
    _adDetailLabel.text = [NSString stringWithFormat:@"%@%@",adItem.adCity,adItem.adDetail];
    _adPhoneLabel.text = [PLSpeedy pl_encryptionDisplayMessageWith:adItem.adPhone withFirstIndex:3];
    _defaultAddressButton.selected = adItem.isDefault;
}
@end
