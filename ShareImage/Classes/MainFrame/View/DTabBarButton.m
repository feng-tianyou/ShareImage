//
//  DTabBarButton.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DTabBarButton.h"
#import "DTabBarBadgeButton.h"

// 按钮文字默认的颜色
#define DTabBarButtonTitleColor (IOS7? [UIColor blackColor] : [UIColor orangeColor])

// 按钮文字选中的颜色
#define DTabBarButtonTitleSelectedColor (IOS7? DColor(234, 103, 7) : DColor(248, 139, 0))

// 图片占据按钮的比例
#define DTabBarButtonImageRatio 0.6

@interface DTabBarButton ()

@property (nonatomic, weak) DTabBarBadgeButton *badgeButton;

@end

@implementation DTabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];

        // 设置文字颜色
//        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self dk_setTitleColorPicker:DKColorPickerWithKey(TABBARTEXT) forState:UIControlStateNormal];
        [self dk_setTitleColorPicker:DKColorPickerWithKey(TABBARTEXT) forState:UIControlStateSelected];
        
        // 增加一个提醒数字按钮
        DTabBarBadgeButton *badgeButton = [[DTabBarBadgeButton alloc] init];
        
        // 固定边缘
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

// 消除高亮状态
- (void)setHighlighted:(BOOL)highlighted{}

- (void)setItem:(UITabBarItem *)item{
    
    _item = item;
    
    
    // KVO 监听属性改变
//    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
//    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
//    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
//    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
//    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

// 消除监听
- (void)dealloc{
    
//    [self removeObserver:self forKeyPath:@"badgeValue"];
//    [self removeObserver:self forKeyPath:@"title"];
//    [self removeObserver:self forKeyPath:@"image"];
//    [self removeObserver:self forKeyPath:@"selectedImage"];
}

/**
 监听到某个对象的属性改变了，就会调用
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    // 设置提醒按钮的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgeFrame = self.badgeButton.frame;
    badgeFrame.origin.x = badgeX;
    badgeFrame.origin.y = badgeY;
    self.badgeButton.frame = badgeFrame;
    
}




#pragma mark - 重写布局

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * DTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * DTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

@end
