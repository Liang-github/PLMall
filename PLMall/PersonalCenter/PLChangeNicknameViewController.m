//
//  PLChangeNicknameViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLChangeNicknameViewController.h"

@interface PLChangeNicknameViewController ()
//改名
@property (nonatomic, strong) UITextField *nickField;
@end

@implementation PLChangeNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - initialize
- (void)setUpInit {
    self.title = @"昵称";
    self.view.backgroundColor = PLBGColor;
}
#pragma mark - 更改昵称
- (void)setUpField {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, 70, ScreenW, 44);
    [self.view addSubview:bgView];
    
    _nickField = [[UITextField alloc] init];
    _nickField.placeholder = _oldNickname;
    _nickField.backgroundColor = [UIColor clearColor];
    _nickField.font = PFR14Font;
    _nickField.clearButtonMode = UITextFieldViewModeAlways;
    [_nickField becomeFirstResponder];
    
    _nickField.frame = CGRectMake(PLMargin, 0, ScreenW - 2*PLMargin, 44);
    [bgView addSubview:_nickField];
    
    UILabel *markLabel = [[UILabel alloc] init];
    markLabel.text = @"请输入20-40个字符串";
    markLabel.textColor = [UIColor lightGrayColor];
    markLabel.font = PFR12Font;
    [self.view addSubview:markLabel];
    markLabel.frame = CGRectMake(PLMargin, bgView.pl_bottom + 5, 200, 35);
    
}
#pragma mark - 导航栏
- (void)setUpNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(surebackItemClick)];
}
#pragma mark -  确定点击
- (void)surebackItemClick {
    if (_nickField.text.length != 0) {
        //更改
        PLUserInfo *userInfo = UserInfoData;
        userInfo.nickname = _nickField.text;
        [userInfo save];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
