//
//  PLMyselfMessageViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLMyselfMessageViewController.h"
#import "PLChangeNicknameViewController.h"
#import "PLReceiverAdressViewController.h"

#import "PLKeepNewUserData.h"

#import "PLSettingCell.h"
#import "PLSelPhotos.h"

#import "JKDBModel.h"

@interface PLMyselfMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *headImageView;

@end

static NSString *const PLSettingCellID = @"PLSettingCell";

@implementation PLMyselfMessageViewController
#pragma mark - LazyLoad
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
#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTab];
}
#pragma mark - initizlize
- (void)setUpTab {
    self.title = @"账户中心";
    self.view.backgroundColor = PLBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? 6 : (section == 1) ? 1 : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLUserInfo *userInfo = UserInfoData;
    PLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:PLSettingCellID forIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell.indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
    if (indexPath.section == 0) {
        NSArray *titles = @[@"头像",@"用户名",@"昵称",@"性别",@"出生日期",@"填写详细资料"];
        cell.type = cellTypeOne;
        if (indexPath.row == 0) {
            cell.contentLabel.hidden = YES;
            _headImageView = [UIButton buttonWithType:UIButtonTypeCustom];
            [cell addSubview:_headImageView];
            _headImageView.pl_size = CGSizeMake(50, 50);
            _headImageView.pl_centerY = cell.pl_centerY;
            _headImageView.pl_x = cell.pl_width - _headImageView.pl_width - PLMargin*4;
            [PLSpeedy pl_setUpBezierPathCircularLayerWith:_headImageView withSize:CGSizeMake(_headImageView.pl_width*0.5, _headImageView.pl_width*0.5)];
            UIImage *image = ([userInfo.userimage isEqualToString:@"icon"]) ? [UIImage imageNamed:@"icon"] : [PLSpeedy base64StrToImage:userInfo.userimage];
            [_headImageView setImage:image forState:UIControlStateNormal];
            _headImageView.userInteractionEnabled = NO;
        } else if (indexPath.row == 1) {
            cell.userInteractionEnabled = NO;
            cell.indicateButton.hidden = YES;
        } else if (indexPath.row == 4) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.type = cellTypeThree;
            cell.birthField.text = userInfo.birthDay;
        }
        cell.titleLabel.text = titles[indexPath.row];
        NSArray *contents = @[@"",userInfo.username,userInfo.nickname,userInfo.sex,@"",@"完善可以涨积分哦"];
        cell.contentLabel.text = contents[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.titleLabel.text = @"收货地址管理";
    } else if (indexPath.section == 2) {
        cell.type = cellTypeOne;
        cell.titleLabel.text = @"账户安全";
        cell.contentLabel.text = @"安全等级：高";
        [PLSpeedy pl_setSomeOneChangeColor:cell.contentLabel setSelectArray:@[@"低",@"中",@"高"] setChangeColor:[UIColor orangeColor]];
        [cell.indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
    }
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return PLMargin;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0 && indexPath.row == 0) ? 66 : 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PLUserInfo *userInfo = UserInfoData;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self changeProfileImage:userInfo];
        } else if (indexPath.row == 2) {
            [self changeNicknameWith:userInfo];
        } else if (indexPath.row == 3) {
            [self changeSex:userInfo];
        }
    } else if (indexPath.section == 1) {
        PLReceiverAdressViewController *reVc = [[PLReceiverAdressViewController alloc] init];
        [self.navigationController pushViewController:reVc animated:YES];
    }
}
#pragma mark - 更改昵称
- (void)changeNicknameWith:(PLUserInfo *)userInfo {
    PLChangeNicknameViewController *changeNickVc = [[PLChangeNicknameViewController alloc] init];
    changeNickVc.oldNickname = userInfo.nickname;
    [self.navigationController pushViewController:changeNickVc animated:YES];
}
#pragma mark - 点击了更换头像
- (void)changeProfileImage:(PLUserInfo *)userInfo {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PLSelPhotos *imageManager = [PLSelPhotos selPhotos];
        [imageManager pushImagePickerControllerWithImagesCount:1 withColumnNumber:3 didFinish:^(TZImagePickerController *imagePickerVc) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf presentViewController:imagePickerVc animated:YES completion:nil];
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (![userInfo.userimage isEqualToString:[PLSpeedy imageToBase64Str:photos.lastObject]]) { //判断
                    [strongSelf.headImageView setImage:photos.lastObject forState:UIControlStateNormal];
                    userInfo.userimage = [PLSpeedy imageToBase64Str:photos.lastObject];
                    
                    [userInfo save];
                }
            }];
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消更换头像");
    }]];
    [weakSelf presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 改变用户性别
- (void)changeSex:(PLUserInfo *)userInfo {
    __weak typeof(self)weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![userInfo.sex isEqualToString:@"女"]) {
            userInfo.sex = @"女";
            [userInfo save];
            [weakSelf.tableView reloadData];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![userInfo.sex isEqualToString:@"男"]) {
            userInfo.sex = @"男";
            [userInfo save];
            [weakSelf.tableView reloadData];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消更换性别");
    }]];
    [weakSelf presentViewController:alert animated:YES completion:nil];
}
@end
