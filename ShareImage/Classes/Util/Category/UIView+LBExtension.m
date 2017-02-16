//
//  UIView+LBExtention.m
//
//  Created by linbing on 15/10/4.
//  Copyright © 2015年 linbing. All rights reserved.
//

//
//  ClassUtils.m
//  TTClub
//
//  Created by RoyLei on 15/7/9.
//  Copyright (c) 2015年 61Seconds. All rights reserved.
//

#import "UIView+LBExtension.h"
#import <objc/runtime.h>

#pragma mark - UIView分类

@implementation UIView (utilView)

/*********************** 快速设置和获取坐标 ********************/

- (void)setX_:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)getX_
{
    return self.frame.origin.x;
}

- (void)setY_:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)getY_
{
    return self.frame.origin.y;
}

- (void)setWidth_:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)getWidth_
{
    return self.frame.size.width;
}

- (void)setHeight_:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)getHeight_
{
    return self.frame.size.height;
}

- (void)setSize_:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)getSize_
{
    return self.frame.size;
}

- (void)setOrigin_:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)getOrigin_
{
    return self.frame.origin;
}

-(void)setRightPoint_:(CGPoint)rightPoint{
    CGRect frame = self.frame;
    frame.origin.x = rightPoint.x - frame.size.width;
    frame.origin.y = rightPoint.y;
    self.frame = frame;
}

-(CGPoint)getRightPoint_
{
    return CGPointMake(self.x + self.width, self.y);
}

-(CGPoint)boundsCenter{
    return CGPointMake(self.width / 2, self.height/2);
}

- (void)setTop_:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)getTop_
{
    return self.y;
}

- (void)setLeft_:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)getLeft_
{
    return self.x;
}

- (void)setBotm_:(CGFloat)botm
{
    self.y = botm - self.botm;
}

- (CGFloat)getBotm_
{
    return self.y + self.height;
}

- (void)setRight_:(CGFloat)right
{
    self.x = right - self.width;
}

- (CGFloat)getRight_
{
    return self.x + self.width;
}

- (void)setCenterX_:(CGFloat)centerX
{
    [self setCenter:(CGPoint){centerX, self.center.y}];
}

- (CGFloat)getCenterX_
{
    return self.center.x;
}

- (void)setCenterY_:(CGFloat)centerY
{
    [self setCenter:(CGPoint){self.center.x, centerY}];
}

- (CGFloat)getCenterY_
{
    return self.center.y;
}

- (void)setFrame:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    [self setFrame:CGRectMake(x, y, w, h)];
}

- (void)setXY:(CGFloat)x Y:(CGFloat)y
{
    CGPoint point;
    point.x = x;
    point.y = y;
    
    self.origin = point;
}

- (void)setSizew:(CGFloat)w h:(CGFloat)h
{
    CGSize size;
    size.width = w;
    size.height = h;
    
    self.size = size;
}

- (CGRect)getFrameApplyAffineTransform_
{
    return CGRectApplyAffineTransform(self.frame, self.transform);
}

- (CGRect)getBoundsApplyAffineTransform_
{
    return CGRectApplyAffineTransform(self.bounds, self.transform);
}

/*********************** 快速设置和获取坐标 end ********************/


/*********************** 快速排版 ********************/

//添加子视图@[]
- (void)addSubviewAry:(NSArray *)objects
{
    for(UIView *vi in objects)
        [self addSubview:vi];
}

//置父视图顶部
- (void)setSuperViewTop
{
    self.y = 0;
}

//置父视图左边
- (void)setSuperViewLeft
{
    self.x = 0;
}

//置父视图底部
- (void)setSuperViewBotm
{
    NSAssert(self.superview, @"not superView!");
    self.y = self.superview.height - self.height;
}

//置父视图右边
- (void)setSuperViewRight
{
    NSAssert(self.superview, @"not superView!");
    self.x = self.superview.width - self.width;
}

//置View到指定View的顶部，并且设置间距
- (void)setTopFromView:(UIView*)vi dis:(CGFloat)dis
{
    self.y = vi.y - dis - self.height;
}

//置View到指定View左边，并且设置间距
- (void)setLeftFromView:(UIView*)vi dis:(CGFloat)dis
{
    self.x = vi.x - dis - self.width;
}

//置View到指定View底部，并且设置间距
- (void)setBotmFromView:(UIView*)vi dis:(CGFloat)dis
{
    self.y = vi.botm + dis;
}

//置View到指定View右边，并且设置间距
- (void)setRightFromView:(UIView*)vi dis:(CGFloat)dis
{
    self.x = vi.right + dis;
}

//置View到指定父视图的顶部，并且设置间距
- (void)setTopFromSuperViewWithDis:(CGFloat)dis
{
    NSAssert(self.superview, @"not superView!");
    self.y = dis;
}

//置View到指定父视图左边，并且设置间距
- (void)setLeftFromSuperViewWithDis:(CGFloat)dis
{
    NSAssert(self.superview, @"not superView!");
    self.x = dis;
}

//置View到指定父视图底部，并且设置间距
- (void)setBotmFromSuperViewWithDis:(CGFloat)dis
{
    NSAssert(self.superview, @"not superView!");
    self.y = self.superview.height - self.height - dis;
}

//置View到指定父视图右边，并且设置间距
- (void)setRightFromSuperViewWithDis:(CGFloat)dis
{
    NSAssert(self.superview, @"not superView!");
    self.x = self.superview.width - self.width - dis;
}

//使用Margin设置坐标-相对父视图
- (void)setMarginTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    NSAssert(self.superview, @"没有父视图!");
    CGRect frame;
    frame.origin.y = top;
    frame.origin.x = left;
    frame.size.height = self.superview.height - frame.origin.y - bottom;
    frame.size.width = self.superview.width - frame.origin.x - right;
    self.frame = frame;
}

//设置UIViewAutoresizingFlexibleLeftMargin
- (void)setLeftMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin;
}

//设置UIViewAutoresizingFlexibleRightMargin
- (void)setRightMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleRightMargin;
}

//设置UIViewAutoresizingFlexibleTopMargin
- (void)setTopMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
}

//设置UIViewAutoresizingFlexibleWidth
- (void)setWidthMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleWidth;
}

//设置UIViewAutoresizingFlexibleHeight
- (void)setHeightMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
}

//设置UIViewAutoresizingFlexibleBottomMargin
- (void)setBottomMargin
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
}

//设置AllMargin
- (void)setAllMargin
{
    [self setLeftMargin];
    [self setRightMargin];
    [self setTopMargin];
    [self setHeightMargin];
    [self setBottomMargin];
}

//输出View的Frame
- (void)ptrFrame
{
    NSLog(@"[%@]", NSStringFromCGRect(self.frame));
}



//使用空白背景颜色
- (void)setBgrClearColor
{
    self.backgroundColor = [UIColor clearColor];
}

/*********************** 快速排版 End ********************/

@end


#pragma mark - NSObject分类
@implementation NSObject (utilNSObject)

+ (NSObject*)allocAndInit
{
    return [[self alloc] init];
}

@end

