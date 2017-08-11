//
//  PLGoodDetailViewController.m
//  PLMall
//
//  Created by PengLiang on 2017/8/11.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "PLGoodDetailViewController.h"
//Controllers
#import "PLGoodBaseViewController.h"
#import "PLGoodParticularsViewController.h"
#import "PLGoodsCommentViewController.h"
#import "PLMyTrolleyViewController.h"
#import "PLToolsViewController.h"

#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
#import "UIBarButtonItem+PLBarButtonItem.h"
@interface PLGoodDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) UIView *bgView;
//记录上一次选择的Button
@property (nonatomic, weak) UIButton *selectBtn;
//标题按钮地下的指示器
@property (nonatomic, weak) UIView *indicatorView;
//通知
@property (nonatomic, weak) id dcObserve;

@end

@implementation PLGoodDetailViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.delegate = self;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewControllers];
    [self setUpInit];
    [self setUpNav];
    [self setUpTopButtonView];
    [self addChildViewController];
    [self setUpBottomButton];
    [self acceptanceNote];
}
#pragma mark - initalize
- (void)setUpInit {
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(self.view.pl_width*self.childViewControllers.count, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark - 接收通知
- (void)acceptanceNote {
    //滚动到详情
    __weak typeof(self) weakSelf = self;
    _dcObserve = [[NSNotificationCenter defaultCenter] addObserverForName:@"scrollToDetailsPage" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf topButtonClick:weakSelf.bgView.subviews[1]];
    }];
    
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"scrollToCommentsPage" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf topButtonClick:weakSelf.bgView.subviews[2]]; //跳转到评论界面
    }];
}
#pragma mark - 头部View
- (void)setUpTopButtonView {
    NSArray *titles = @[@"商品",@"详情",@"评价"];
    CGFloat margin = 5;
    _bgView = [[UIView alloc] init];
    _bgView.pl_centerX = ScreenW*0.5;
    _bgView.pl_height = 44;
    _bgView.pl_width = (_bgView.pl_height + PLMargin)*titles.count;
    _bgView.pl_y = 0;
    self.navigationItem.titleView = _bgView;
    
    CGFloat buttonW = _bgView.pl_height;
    CGFloat buttonH = _bgView.pl_height;
    CGFloat buttonY = _bgView.pl_y;
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        button.tag = i;
        button.titleLabel.font = PFR15Font;
        [button addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = i*(buttonX + margin);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [_bgView addSubview:button];
    }
    UIButton *firstButton = _bgView.subviews[0];
    [self topButtonClick:firstButton]; //默认选择第一个
    
    UIView *indicatorView = [[UIView alloc] init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    indicatorView.pl_height = 2;
    indicatorView.pl_y = _bgView.pl_height - indicatorView.pl_height;
    [firstButton.titleLabel sizeToFit];
    indicatorView.pl_width = firstButton.titleLabel.pl_width;
    indicatorView.pl_centerX = firstButton.pl_centerX;
    [_bgView addSubview:indicatorView];
}
#pragma mark - 添加子控制器View
- (void)addChildViewController {
    NSInteger index = _scrollerView.contentOffset.x/_scrollerView.pl_width;
    UIViewController *childVc = self.childViewControllers[index];
    if (childVc.view.superview) {
        return;
    }
    childVc.view.frame = CGRectMake(index*_indicatorView.pl_width, 0, _scrollerView.pl_width, _scrollerView.pl_height);
    [_scrollerView addSubview:childVc.view];
}
#pragma mark - 添加子控制器
- (void)setUpChildViewControllers {
    __weak typeof(self) weakSelf = self;
    PLGoodBaseViewController *goodBaseVc = [[PLGoodBaseViewController alloc] init];
    goodBaseVc.goodTitle = _goodTitle;
    goodBaseVc.goodPrice = _goodPrice;
    goodBaseVc.goodSubTitle = _goodSubTitle;
    goodBaseVc.shufflingArray = _shufflingArray;
    goodBaseVc.goodImageView = _goodImageView;
    goodBaseVc.changeTitleBlock = ^(BOOL isChange) {
        if (isChange) {
            weakSelf.title = @"图文详情";
            weakSelf.navigationItem.titleView = nil;
            self.scrollerView.contentSize = CGSizeMake(self.view.pl_width, 0);
        } else {
            weakSelf.title = nil;
            weakSelf.navigationItem.titleView = weakSelf.bgView;
            self.scrollerView.contentSize = CGSizeMake(self.view.pl_width*self.childViewControllers.count, 0);
        }
    };
    [self addChildViewController:goodBaseVc];
    
    PLGoodParticularsViewController *goodParticularsVc = [[PLGoodParticularsViewController alloc] init];
    [self addChildViewController:goodParticularsVc];
    
    PLGoodsCommentViewController *goodCommentVc = [[PLGoodsCommentViewController alloc] init];
    [self addChildViewController:goodCommentVc];
}
#pragma mark - 底部按钮（收藏 购物车 加入购物车 立即购买）
- (void)setUpBottomButton {
    [self setUpLeftTwoButton]; //收藏 购物车
    [self setUpRightTwoButton]; //加入购物车 立即购买
}
#pragma mark - 收藏 购物车
- (void)setUpLeftTwoButton {
    NSArray *imagesNor = @[@"tabr_07shoucang_up",@"tabr_08gouwuche"];
    NSArray *imagesSel = @[@"tabr_07shoucang_down",@"tabr_08gouwuche"];
    CGFloat buttonW = ScreenW *0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    
    for (NSInteger i = 0; i < imagesNor.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:0];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = buttonW*i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton {
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = ScreenW*0.6*0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        [button setTitleColor:[UIColor whiteColor] forState:0];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : RGB(249, 125, 10);
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW*0.4 + (buttonW*i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:button];
    }
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self addChildViewController];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.pl_width;
    UIButton *button = _bgView.subviews[index];
    [self topButtonClick:button];
    [self addChildViewController];
}
#pragma mark - 导航栏设置
- (void)setUpNav {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"Details_Btn_More_normal"] withHighlighted:[UIImage imageNamed:@"Details_Btn_More_normal"] target:self action:@selector(toolItemClick)];
}
#pragma mark - 点击事件
#pragma mark - 头部按钮点击
- (void)topButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor blackColor] forState:0];
    [button setTitleColor:[UIColor redColor] forState:0];
    
    _selectBtn = button;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.pl_width = button.titleLabel.pl_width;
        weakSelf.indicatorView.pl_centerX = button.pl_centerX;
    }];
    
    CGPoint offset = _scrollerView.contentOffset;
    offset.x = _scrollerView.pl_width*button.tag;
    [_scrollerView setContentOffset:offset animated:YES];
}
#pragma mark - 点击工具条
- (void)toolItemClick {
    [self setUpAlterViewControllerWith:[PLToolsViewController new] WithDistance:150 WithDirection:XWDrawerAnimatorDirectionTop WithParallaxEnable:NO WithFlipEnable:NO];
}
- (void)bottomButtonClick:(UIButton *)button {
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    } else if (button.tag == 1) {
        NSLog(@"购物车");
        PLMyTrolleyViewController *shopCarVc = [[PLMyTrolleyViewController alloc] init];
        shopCarVc.isTabBar = YES;
        shopCarVc.title = @"购物车";
        [self.navigationController pushViewController:shopCarVc animated:YES];
    } else if (button.tag == 2 || button.tag == 3) {
        //父控制器的加入购物车和立即购买
        //异步发通知
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%zd",button.tag],@"buttonTag", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ClikAddOrBuy" object:nil userInfo:dict];
        });
    }
}
#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlertViewback];
    }];
}
- (void)selfAlertViewback {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
}
@end
