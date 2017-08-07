//
//  PLSettingCell.m
//  PLMall
//
//  Created by PengLiang on 2017/8/7.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLSettingCell.h"

@interface PLSettingCell ()
//日期上方工具条
@property (nonatomic, strong) UIToolbar *textFieldToolbar;
//日期DatePicker
@property (nonatomic, strong) UIDatePicker *datePicker;

@end
@implementation PLSettingCell

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        //设置显示模式
        _datePicker.datePickerMode = UIDatePickerModeDate;
        //本地化
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    }
    return _datePicker;
}
- (UIView *)textFieldToolbar {
    if (!_textFieldToolbar) {
        _textFieldToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        _textFieldToolbar.backgroundColor = [UIColor whiteColor];
        //设置按钮
        UIBarButtonItem *fixSpaceBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishBirthChange)];
        [doneBtn setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateNormal];
        _textFieldToolbar.items = @[fixSpaceBtn,doneBtn];
    }
    return _textFieldToolbar;
}
#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR15Font;
    
    _setSwitch = [[UISwitch alloc] init];
    [_setSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    _setSwitch.onTintColor = [UIColor redColor];
    
    _indicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.font = PFR13Font;
    
    _birthField = [[UITextField alloc] init];
    _birthField.borderStyle = 0;
    //设置文本输入框的输入辅助视图为自定义的视图
    _birthField.inputAccessoryView = self.textFieldToolbar;
    //设置文本输入框的输入视图为自定义的datePicker;
    _birthField.inputView = self.datePicker;
    _birthField.textColor = [UIColor darkGrayColor];
    _birthField.font = PFR13Font;
}
#pragma mark - Setter Getter Methods
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(PLMargin);
        make.centerY.equalTo(self);
    }];
    if (_type == cellTypeOne) {
        [self addSubview:_indicateButton];
        [self addSubview:_contentLabel];
        
        [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-PLMargin);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.equalTo(self);
        }];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_indicateButton.mas_left);
            make.centerY.equalTo(self);
        }];
    } else if (_type == cellTypeTwo) {
        [self addSubview:_setSwitch];
        [_setSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-PLMargin);
            make.size.mas_equalTo(CGSizeMake(60, 35));
            make.centerY.equalTo(self);
        }];
    } else if (_type == cellTypeThree) {
        [self addSubview:_birthField];
        [self addSubview:_indicateButton];
        [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-PLMargin);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.equalTo(self);
        }];
        [_birthField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_indicateButton.mas_left);
            make.centerY.equalTo(self);
        }];
    }
}
- (void)switchAction:(UISwitch *)sender {
    NSLog(@"%@",sender.isOn ? @"NO" : @"OFF");
}
#pragma mark - 更换生日结束
- (void)finishBirthChange {
    PLUserInfo *userInfo = UserInfoData;
    NSDate *choosedDate = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; //设置日期格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *birthDayStr = [formatter stringFromDate:choosedDate];
    if (![birthDayStr isEqualToString:_birthField.text]) {
        //更换日期
        userInfo.birthDay = birthDayStr;
        [userInfo save];
        _birthField.text = birthDayStr;
    }
    [_birthField resignFirstResponder];
}
@end
