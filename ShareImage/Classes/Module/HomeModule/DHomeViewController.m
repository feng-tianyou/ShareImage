//
//  DHomeViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DHomeViewController.h"
#import "DSearchPhotoController.h"
#import "DUserProfileViewController.h"
#import "DPhotoDetailController.h"

#import "DHomeTableViewCell.h"
#import "DHomeMenuView.h"

#import "DPhotosAPIManager.h"
#import "DCollectionsAPIManager.h"
#import "DUserAPIManager.h"

#import "DPhotosParamModel.h"
#import "DCollectionsParamModel.h"
#import "DPhotosModel.h"
#import "DUserParamModel.h"

#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LLSlideMenu.h"


@interface DHomeViewController ()<UITableViewDelegate, UITableViewDataSource, DHomeMenuViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, assign) NSInteger page;

// =============  菜单部分 ============
@property (nonatomic, strong) LLSlideMenu *slideMenu;
// 全屏侧滑手势
@property (nonatomic, strong) UIPanGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percent;


@end

@implementation DHomeViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.navLeftItemType = DNavigationItemTypeRightMenu;
    self.navRighItemType = DNavigationItemTypeRightSearch;
    
    // 初始化上下拉刷新
    [self setupTableViewUpAndDowmLoad];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    // 布局子视图
    [self setupSubViewsAutoLayout];
    
    // 初始化菜单
    [self setupSwipeMenu];
}

#pragma mark - 菜单部分
- (void)setupSwipeMenu{
    [self.tabBarController.view addSubview:self.slideMenu];
    [self.tabBarController.view addGestureRecognizer:self.leftSwipe];

}

// 全屏侧滑手势监听
- (void)swipeLeftHandle:(UIScreenEdgePanGestureRecognizer *)recognizer {
    self.slideMenu.hidden = NO;
    // 如果菜单已打开则禁止滑动
    if (_slideMenu.ll_isOpen || _slideMenu.ll_isAnimating) {
        return;
    }
    // 计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    // 把这个百分比限制在 0~1 之间
    progress = MIN(1.0, MAX(0.0, progress));
    
    // 当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percent = [[UIPercentDrivenInteractiveTransition alloc] init];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        // 当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percent updateInteractiveTransition:progress];
        _slideMenu.ll_distance = [recognizer translationInView:self.view].x;
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        // 当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.4) {
            [self.percent finishInteractiveTransition];
            [_slideMenu ll_openSlideMenu];
        }else{
            [self.percent cancelInteractiveTransition];
            [_slideMenu ll_closeSlideMenu];
        }
        self.percent = nil;
    }
}



#pragma mark - 私有方法
- (void)setupSubViewsAutoLayout{
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
}

- (void)getPhotosData{
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.page = self.page;
    paramModel.per_page = 20;
    [manager fetchPhotosByParamModel:paramModel];
}


/**
 设置上下拉刷新
 */
- (void)setupTableViewUpAndDowmLoad{
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            self.page = 1;
            [self getPhotosData];
        });
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self getPhotosData];
        });
    }];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHomeTableViewCell *cell = [DHomeTableViewCell cellWithTableView:tableView];
    
    if (self.photos.count > indexPath.row) {
        DPhotosModel *model = self.photos[indexPath.row];
        cell.photosModel = model;
        DUserModel *userModel = model.user;
        [cell setClickIconBlock:^{
            DLog(@"点击头像");
            DUserProfileViewController *userController = [[DUserProfileViewController alloc] initWithUserName:userModel.username];
            [self.navigationController pushViewController:userController animated:YES];
        }];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.photos[indexPath.row];
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"photosModel" cellClass:[DHomeTableViewCell class] contentViewWidth:self.view.width];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.photos.count > indexPath.row) {
        DPhotoDetailController *detailController = [[DPhotoDetailController alloc] initWithPhotoModel:self.photos[indexPath.row]];
        [self.navigationController pushViewController:detailController animated:YES];
    }
}


#pragma mark - DHomeMenuViewDelegate
- (void)homeMenuView:(DHomeMenuView *)homeMenuView didClickHeaderView:(DHomeMenuHeader *)headerView{
    DLog(@"点击头部");
}

- (void)homeMenuView:(DHomeMenuView *)homeMenuView didSelectIndex:(NSInteger)selectIndex{
    DLog(@"点击--%@", @(selectIndex));
}

#pragma mark - 导航栏点击事件
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (isLeft) {
        self.slideMenu.hidden = NO;
        if (self.slideMenu.ll_isOpen) {
            [self.slideMenu ll_closeSlideMenu];
        } else {
            [self.slideMenu ll_openSlideMenu];
        }
        
        
    } else {
        
    }
}





#pragma mark - 请求回调
- (void)requestServiceSucceedBackArray:(NSArray *)arrData userInfo:(NSDictionary *)userInfo{
    
    self.page++;
    [self.photos addObjectsFromArray:arrData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)unlockUI{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)clearData{
    [self.photos removeAllObjects];
}

- (void)hasNotMoreData{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark - getter & setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    }
    return _tableView;
}

- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (LLSlideMenu *)slideMenu{
    if (!_slideMenu) {
        _slideMenu = [[LLSlideMenu alloc] init];
        // 设置菜单宽度  menu width
        _slideMenu.ll_menuWidth = 200.f;
        
        // 设置菜单背景色  background color
        _slideMenu.ll_menuBackgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        
        // 设置菜单背景图片  background image
//        _slideMenu.ll_menuBackgroundImage = [UIImage imageNamed:@"image"];
        _slideMenu.ll_distance = 100.f;     // 拉伸距离  pulling distance
        _slideMenu.ll_springDamping = 20;       // 阻力
        _slideMenu.ll_springVelocity = 15;      // 速度
        _slideMenu.ll_springFramesNum = 60;     // 关键帧数量
        _slideMenu.hidden = YES;
        
        DHomeMenuView *menuView = [[DHomeMenuView alloc] init];
        [menuView setFrame:0 y:0 w:200 h:SCREEN_HEIGHT];
        menuView.delegate = self;

        [_slideMenu addSubview:menuView];
        
        
    }
    return _slideMenu;
}

- (UIPanGestureRecognizer *)leftSwipe{
    if (!_leftSwipe) {
        _leftSwipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandle:)];
        _leftSwipe.maximumNumberOfTouches = 1;
    }
    return _leftSwipe;
}

@end
