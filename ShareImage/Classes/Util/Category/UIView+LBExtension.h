//
//  UIView+LBExtention.h
//
//  Created by linbing on 15/10/4.
//  Copyright © 2015年 linbing. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIView (utilView)

@property (nonatomic, getter = getX_, setter = setX_:) CGFloat x;
@property (nonatomic, getter = getY_, setter = setY_:) CGFloat y;
@property (nonatomic, getter = getWidth_, setter = setWidth_:) CGFloat width;
@property (nonatomic, getter = getHeight_, setter = setHeight_:) CGFloat height;
@property (nonatomic, getter = getSize_, setter = setSize_:)CGSize size;
@property (nonatomic, getter = getOrigin_, setter = setOrigin_:)CGPoint origin;
@property (nonatomic, getter = getRightPoint_, setter = setRightPoint_:)CGPoint rightPoint;
@property (nonatomic, assign,readonly) CGPoint boundsCenter;

@property (nonatomic, setter = setTop_:, getter = getTop_) CGFloat top;
@property (nonatomic, setter = setLeft_:, getter = getLeft_) CGFloat left;
@property (nonatomic, setter = setBotm_:, getter = getBotm_) CGFloat botm;
@property (nonatomic, setter = setRight_:, getter = getRight_) CGFloat right;

@property (nonatomic, getter = getCenterX_, setter = setCenterX_:) CGFloat centerX;
@property (nonatomic, getter = getCenterY_, setter = setCenterY_:) CGFloat centerY;

@property (nonatomic, readonly, getter = getFrameApplyAffineTransform_) CGRect frameApplyAffineTransform;

- (void)setFrame:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;
- (void)setXY:(CGFloat)x Y:(CGFloat)y;
- (void)setSizew:(CGFloat)w h:(CGFloat)h;

//添加子视图@[]
- (void)addSubviewAry:(NSArray *)objects;

//置父视图顶部
- (void)setSuperViewTop;
//置父视图左边
- (void)setSuperViewLeft;
//置父视图底部
- (void)setSuperViewBotm;
//置父视图右边
- (void)setSuperViewRight;

//置View到指定View的顶部，并且设置间距
- (void)setTopFromView:(UIView*)vi dis:(CGFloat)dis;
//置View到指定View左边，并且设置间距
- (void)setLeftFromView:(UIView*)vi dis:(CGFloat)dis;
//置View到指定View底部，并且设置间距
- (void)setBotmFromView:(UIView*)vi dis:(CGFloat)dis;
//置View到指定View右边，并且设置间距
- (void)setRightFromView:(UIView*)vi dis:(CGFloat)dis;

//置View到指定父视图的顶部，并且设置间距
- (void)setTopFromSuperViewWithDis:(CGFloat)dis;
//置View到指定父视图左边，并且设置间距
- (void)setLeftFromSuperViewWithDis:(CGFloat)dis;
//置View到指定父视图底部，并且设置间距
- (void)setBotmFromSuperViewWithDis:(CGFloat)dis;
//置View到指定父视图右边，并且设置间距
- (void)setRightFromSuperViewWithDis:(CGFloat)dis;

//使用Margin设置坐标-相对父视图
- (void)setMarginTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

//设置UIViewAutoresizingFlexibleLeftMargin
- (void)setLeftMargin;
//设置UIViewAutoresizingFlexibleRightMargin
- (void)setRightMargin;
//设置UIViewAutoresizingFlexibleWidth
- (void)setWidthMargin;
//设置UIViewAutoresizingFlexibleTopMargin
- (void)setTopMargin;
//设置UIViewAutoresizingFlexibleHeight
- (void)setHeightMargin;
//设置UIViewAutoresizingFlexibleBottomMargin
- (void)setBottomMargin;
//设置AllMargin
- (void)setAllMargin;

//输出View的Frame
- (void)ptrFrame;

@end




@interface NSObject (LBExtension)

//快速初始化
+ (NSObject*)allocAndInit;


@end

