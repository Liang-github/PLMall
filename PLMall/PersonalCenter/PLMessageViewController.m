//
//  PLMessageViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/8.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLMessageViewController.h"
#import "PLMessageItem.h"
#import "PLMessageNoteCell.h"
#import <MJExtension.h>
@interface PLMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *property;
@property (nonatomic, strong) NSMutableArray <PLMessageItem *> *messageItems;

@end
static NSString *const PLMessageNoteCellID = @"PLMessageNoteCell";
@implementation PLMessageViewController
#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 64, ScreenW, ScreenH - 64);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = 0;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[PLMessageNoteCell class] forCellReuseIdentifier:PLMessageNoteCellID];
    }
    return _tableView;
}
- (NSMutableArray <PLMessageItem *> *)messageItems {
    if (!_messageItems) {
        _messageItems = [NSMutableArray array];
    }
    return _messageItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTab];
    [self setUpMessageData];
}
- (void)setUpTab {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = PLBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
}
- (void)setUpMessageData {
    _messageItems = [PLMessageItem mj_objectArrayWithFilename:@"MessageNote.plist"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLMessageNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:PLMessageNoteCellID forIndexPath:indexPath];
    cell.messageItem = _messageItems[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
