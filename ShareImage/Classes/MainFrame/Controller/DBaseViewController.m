//
//  DBaseViewController.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"
#import "DNavigationTool.h"

@interface DBaseViewController ()

@end

@implementation DBaseViewController
#pragma mark - 父类方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 取消上下的边距(导航栏跟tabbar栏)
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];

}

#pragma mark - 状态栏

/**
 重写preferredStatusBarStyle，改变状态栏
 
 @return
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - setter & getter

- (NSMutableDictionary *)networkUserInfo{
    if(_networkUserInfo == nil){
        _networkUserInfo = [NSMutableDictionary new];
        NSString *viewName = NSStringFromClass([self class]);
        [_networkUserInfo setObject:viewName forKey:KVIEWNAME];
        [_networkUserInfo setObject:@(YES) forKey:KNOTNETWORKALERT];
    }
    return _networkUserInfo;
}


- (void)setNavLeftItemType:(DNavigationItemType)navLeftItemType{
    UIButton *button = [self getBarButtonItemWithType:navLeftItemType isLeft:YES isTitle:NO];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //创建UIBarButtonSystemItemFixedSpace
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -7;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem, backButtonItem];
    
}

- (void)setNavRighItemType:(DNavigationItemType)navRighItemType{
    UIButton *button = [self getBarButtonItemWithType:navRighItemType isLeft:NO isTitle:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#define kNAVIGATION_LEFT_ITEM_TAG        10001
#define kNAVIGATION_RIGHT_ITEM_TAG       10002
#define kNAVIGATION_TITLE_ITEM_TAG       10003
- (UIButton *)getBarButtonItemWithType:(DNavigationItemType)type isLeft:(BOOL)isLeft isTitle:(BOOL)isTitle{
    UIButton *button = nil;
    switch (type) {
        case DNavigationItemTypeNone:{
            break;
        }
        case DNavigationItemTypeBack:
        case DNavigationItemTypeBackHome:
        case DNavigationItemTypeRightHome:
        case DNavigationItemTypeRightSend:
        case DNavigationItemTypeRightSave:
        case DNavigationItemTypeRightClear:
        case DNavigationItemTypeRightNext:
        case DNavigationItemTypeRightPublic:
        case DNavigationItemTypeRightCancel:
        case DNavigationItemTypeRightFinish:
        case DNavigationItemTypeRightFeedback:
        case DNavigationItemTypeRightShare:
        case DNavigationItemTypeRightSetting:
        case DNavigationItemTypeRightQuestion:
        case DNavigationItemTypeRightPoint:
        case DNavigationItemTypeRightAdd:{
            
            NSString *strTitle = [DNavigationTool getNavigationBarRightTitleByType:type];
            UIImage *img = [DNavigationTool getNavigationBarRightImgByType:type];
            
            button = [[UIButton alloc] init];
            CGSize size = CGSizeZero;
            if (strTitle.length > 0) {
                button.titleLabel.textAlignment = NSTextAlignmentCenter;
                size = [strTitle sizeWithFont:[UIFont systemFontOfSize:15.0] maxWidth:MAXFLOAT];
                [button setTitle:strTitle forState:UIControlStateNormal];
                [button setTitle:strTitle forState:UIControlStateHighlighted];
                [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
                [button.titleLabel setTextColor:[UIColor whiteColor]];
                [button setFrame:0 y:0 w:size.width h:size.height];
            }
            
            if (img) {
//                size = CGSizeMake(20.0, 20.0);
                size = img.size;
                button.contentMode = UIViewContentModeCenter;
                [button setImage:img forState:UIControlStateNormal];
                [button setImage:img forState:UIControlStateHighlighted];
                [button setFrame:0 y:0 w:size.width h:size.height];
            }
            break;
        }
    }
    
    if (button) {
        button.tag = kNAVIGATION_LEFT_ITEM_TAG;
        if (!isLeft) {
            button.tag = kNAVIGATION_RIGHT_ITEM_TAG;
        }
        if (isTitle) {
            button.tag = kNAVIGATION_TITLE_ITEM_TAG;
        }
        [button addTarget:self action:@selector(navigationItemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return button;
}

- (void)setNavTitleItemType:(DNavigationItemType)navTitleItemType{
    self.navigationItem.titleView = [self getBarButtonItemWithType:navTitleItemType isLeft:NO isTitle:YES];
}

- (void)navigationItemClick:(UIButton *)button{
    switch (button.tag) {
        case kNAVIGATION_LEFT_ITEM_TAG:
            [self baseViewControllerDidClickNavigationLeftBtn:button];
            [self baseViewControllerDidClickNavigationBtn:button isLeft:YES];
            break;
        case kNAVIGATION_RIGHT_ITEM_TAG:
            [self baseViewControllerDidClickNavigationRightBtn:button];
            [self baseViewControllerDidClickNavigationBtn:button isLeft:NO];
            break;
        case kNAVIGATION_TITLE_ITEM_TAG:
            [self baseViewControllerDidClickNavigationTitleBtn:button];
            break;
            
        default:
            break;
    }
}


#pragma mark - navigation(子类重写方法)
/**
 导航栏左右按钮点击事件（子类重写即可）
 
 @param navBtn 导航按钮
 @param isLeft 是否是左按钮
 */
- (void)baseViewControllerDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{}
/**
 导航栏左按钮点击事件（子类重写即可）
 
 @param leftBtn 左按钮
 */
- (void)baseViewControllerDidClickNavigationLeftBtn:(UIButton *)leftBtn{}
/**
 导航栏右按钮点击事件（子类重写即可）
 
 @param rightBtn 右按钮
 */
- (void)baseViewControllerDidClickNavigationRightBtn:(UIButton *)rightBtn{}
/**
 导航栏标题按钮点击事件（子类重写即可）
 
 @param titleBtn 标题按钮
 */
- (void)baseViewControllerDidClickNavigationTitleBtn:(UIButton *)titleBtn{}

@end
