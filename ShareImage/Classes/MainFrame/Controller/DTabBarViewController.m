//
//  DTabBarViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DTabBarViewController.h"
#import "DNavigationViewController.h"
#import "DTabBar.h"

static NSString *const DHomeViewControllerName = @"DHomeViewController";
static NSString *const DCollectionViewControllerName = @"DCollectionViewController";
//static NSString *const DDiscoverViewControllerName = @"DDiscoverViewController";
//static NSString *const DMeViewControllerName = @"DMeViewController";


@interface DTabBarViewController ()<DTabBarDelegate>

@property (nonatomic, weak) DTabBar *customerTabBar;

@end

@implementation DTabBarViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tabBar.barTintColor = [UIColor whiteColor];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.customerTabBar.frame = self.tabBar.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化TabBar
    [self setupTabBar];
    
    // 初始化所有子控制器
    [self setupAllChildViewController];
}

- (void)setupTabBar{
    DTabBar *customerTabBar = [[DTabBar alloc] init];
    customerTabBar.delagate = self;
    [self.tabBar addSubview:customerTabBar];
    self.customerTabBar = customerTabBar;
}


- (void)setupAllChildViewController{
    
    // 首页
    [self setupChildViewController:DHomeViewControllerName title: kLocalizedLanguage(@"tabHome") imageName:@"tabbar_home" selectedImageName:@"tabbar_home_select"];
    
    // 消息
    [self setupChildViewController:DCollectionViewControllerName title:kLocalizedLanguage(@"tabCollection") imageName:@"tabbar_contract" selectedImageName:@"tabbar_contract_select"];

    // 广场
//    [self setupChildViewController:DDiscoverViewControllerName title:@"聊天" imageName:@"tabbar_chat" selectedImageName:@"tabbar_chat_select"];
//    
//    // 我
//    [self setupChildViewController:DMeViewControllerName title:@"我" imageName:@"tabbar_me" selectedImageName:@"tabbar_me_select"];
    
}

/**
 初始化一个子控制器
 */
- (void)setupChildViewController:(NSString *)controllerName title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    if (controllerName.length == 0) return;
    
    Class childClass = NSClassFromString(controllerName);
    UIViewController *child = [[childClass alloc] init];
    
    // 设置控制器的属性
    child.title = title;
    child.tabBarItem.image = [UIImage getImageWithName:imageName];
    
    UIImage *selectedImage = [UIImage getImageWithName:selectedImageName];
    child.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 包装一个导航控制器
    DNavigationViewController *childNav = [[DNavigationViewController alloc] initWithRootViewController:child];
    [self addChildViewController:childNav];
    
    // 自定义导航栏
    [self.customerTabBar addTabBarButtonWithItem:child.tabBarItem];
    
}

- (void)dealloc{
    
}

#pragma mark -DTabBarDelegate方法
- (void)tabBar:(DTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    self.selectedIndex = to;
}

@end
