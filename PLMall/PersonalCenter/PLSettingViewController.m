//
//  PLSettingViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLSettingViewController.h"
#import "PLHelpBackViewController.h"
#import "PLSettingCell.h"
#import "WJYAlertView.h"
@interface PLSettingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end
static NSString *const PLSettingCellID = @"PLSettingCell";
@implementation PLSettingViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = 0;
        _tableView.frame = CGRectMake(0, PLTopNavH, ScreenW, ScreenH - PLTopNavH);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[PLSettingCell class] forCellReuseIdentifier:PLSettingCellID];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTab];
    [self setUpBottomButton];
}

- (void)setUpTab {
    self.view.backgroundColor = PLBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)setUpBottomButton {
    UIView *buttonView = [[UIView alloc] init];
    buttonView.pl_height = 44;
    
    UIButton *logOffBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOffBtn setBackgroundImage:[UIImage imageNamed:@"btn_LogOff_red"] forState:UIControlStateNormal];
    [logOffBtn setTitle:@"注销登录" forState:0];
    logOffBtn.pl_height = buttonView.pl_height;
    logOffBtn.pl_x = 20;
    logOffBtn.pl_width = ScreenW - 40;
    [buttonView addSubview:logOffBtn];
    
    [logOffBtn addTarget:self action:@selector(logOffBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = buttonView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? 1 : (section == 1) ? 2 : (section == 2) ? 1 : (section == 3) ? 4 : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:PLSettingCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 0) {
        cell.type = cellTypeOne;
        cell.titleLabel.text = @"账户安全";
        cell.contentLabel.text = @"安全等级：高";
        [PLSpeedy pl_setSomeOneChangeColor:cell.contentLabel setSelectArray:@[@"低",@"中",@"高"] setChangeColor:[UIColor orangeColor]];
        [cell.indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.type = cellTypeTwo;
            cell.titleLabel.text = @"智能省流量";
            cell.setSwitch.on = YES;
        } else if (indexPath.row == 1) {
            cell.type = cellTypeOne;
            cell.titleLabel.text = @"清除缓存";
            cell.contentLabel.text = @"6.66M";
            [cell.indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
        }
    } else if (indexPath.section == 2) {
        cell.type = cellTypeTwo;
        cell.titleLabel.text = @"接收消息通知";
        cell.setSwitch.on = NO;
    } else if (indexPath.section == 3) {
        cell.type = cellTypeOne;
        NSArray *titles = @[@"关于作者",@"帮助反馈",@"给我的GitHub点星",@"邮箱地址：1075101924@qq.com"];
        cell.titleLabel.text = titles[indexPath.row];
        if (indexPath.row == 3) {
            [cell.indicateButton setImage:[UIImage imageNamed:@"BZFK_newdianhua"] forState:UIControlStateNormal];
        } else {
            [cell.indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PLHelpBackViewController *helpVc = [[PLHelpBackViewController alloc] init];
    [self.navigationController pushViewController:helpVc animated:YES];
}
- (void)logOffBtnClick {
    __weak typeof(self) weakSelf = self;
    [WJYAlertView showTwoButtonsWithTitle:@"温馨提示" Message:@"是否确定退出登录" ButtonType:WJYAlertViewButtonTypeWarn ButtonTitle:@"确定" Click:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } ButtonType:WJYAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:nil];
}
@end
