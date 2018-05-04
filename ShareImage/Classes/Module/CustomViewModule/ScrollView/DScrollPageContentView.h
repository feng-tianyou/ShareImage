//
//  DScrollPageContentView.h
//  ShareImage
//
//  Created by FTY on 2018/5/3.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DScrollPageContentView;
@protocol DScrollPageContentViewDelegate <NSObject>
@optional

/**
 滚动视图时触发此方法(多次触发)
 
 @param pageContentView 当前视图
 @param progress 进度（0-1）
 @param originalIndex 原始下标
 @param targetIndex 目标下标
 */
- (void)pageContentView:(DScrollPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;

/**
 滚动视图后停止时触发此方法（只触发一次）
 
 @param pageContentView 当前视图
 @param targetIndex 目标下标
 */
- (void)pageContentView:(DScrollPageContentView *)pageContentView targetIndex:(NSInteger)targetIndex;


@end

@interface DScrollPageContentView : UIView

/**
 *  对象方法创建 TGScrollPageContentView
 *
 *  @param frame     frame
 *  @param chileMainViews     子视图
 */
- (instancetype)initWithFrame:(CGRect)frame childMainViews:(NSArray *)chileMainViews;
/**
 *  类方法创建 TGScrollPageContentView
 *
 *  @param frame     frame
 *  @param chileMainViews     子视图
 */
+ (instancetype)initWithFrame:(CGRect)frame childMainViews:(NSArray *)chileMainViews;

/// 代理
@property (nonatomic, weak) id<DScrollPageContentViewDelegate> delegate;
/// 有多少个chileMainViews就要多少个chileMainHeaderViews，不需要的添加[UIView new]占位即可
@property (nonatomic, strong) NSArray *chileMainHeaderViews;
// /是否可滑动切换(默认是YES)
@property (nonatomic,assign) BOOL is_scroll;
/// 当前视图下标
@property (nonatomic,assign, readonly) NSInteger currentIndex;

/// 选中哪一个页面
- (void)setPageCententViewCurrentIndex:(NSInteger)currentIndex;
- (void)scrollsToTop:(BOOL)top;

- (void)reloadData;

@end
