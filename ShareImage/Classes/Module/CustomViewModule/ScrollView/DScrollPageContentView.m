//
//  DScrollPageContentView.m
//  ShareImage
//
//  Created by FTY on 2018/5/3.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import "DScrollPageContentView.h"

@interface DScrollPageContentView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *childMainViews;
@property (nonatomic, assign) NSInteger startOffsetX;
@property (nonatomic, assign) BOOL isClickBtn;

@end

@implementation DScrollPageContentView


//生命周期
#pragma mark <----life cycle---->

- (instancetype)initWithFrame:(CGRect)frame childMainViews:(NSArray *)chileMainViews{
    if(self = [super initWithFrame:frame]){
        _childMainViews = chileMainViews;
        [self proccessData];
        [self proccessView];
    }
    return self;
}

+ (instancetype)initWithFrame:(CGRect)frame childMainViews:(NSArray *)chileMainViews{
    return [[self alloc] initWithFrame:frame childMainViews:chileMainViews];
}

- (void)proccessData{
    self.isClickBtn = NO;
    self.is_scroll = YES;
    self.startOffsetX = 0;
    _currentIndex = 0;
    
}

- (void)proccessView{
    
    // 添加collectionview
    [self addSubview:self.collectionView];
    
}

- (void)reloadData{
    [_collectionView reloadData];
}

//代理方法
#pragma mark <----Delegate---->
#pragma mark <----UICollectionViewDelegate, UICollectionViewDataSource---->
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childMainViews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 设置内容
    UIView *view = self.childMainViews[indexPath.item];
    view.frame = cell.contentView.frame;
    if (self.chileMainHeaderViews.count > indexPath.item) {
        UIView *headerView = self.chileMainHeaderViews[indexPath.item];
        if (headerView && headerView.frame.size.height > 0) {
            [cell.contentView addSubview:headerView];
            view.frame = CGRectMake(cell.contentView.frame.origin.x, headerView.frame.size.height, cell.contentView.frame.size.width, cell.contentView.frame.size.height - headerView.frame.size.height);
        }
    }
    [cell.contentView addSubview:view];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (!self.is_scroll)
    {
        return;
    }
    
    self.isClickBtn = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isClickBtn == YES || !self.is_scroll) {
        return;
    }
    
    CGFloat progress = 0;
    NSInteger originalIndex = 0;
    NSInteger targetIndex = 0;
    
    // 判断左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    if (currentOffsetX > self.startOffsetX) {
        // 计算Propress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        originalIndex = currentOffsetX / scrollViewW;
        targetIndex = originalIndex + 1;
        
        if (targetIndex >= self.childMainViews.count) {
            // 滑到底了
            progress = 1;
            targetIndex = originalIndex;
        }
        
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = originalIndex;
        }
    } else {
        // 右滑
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        targetIndex = currentOffsetX / scrollViewW;
        originalIndex = targetIndex + 1;
        if (originalIndex >= self.childMainViews.count) {
            originalIndex = self.childMainViews.count - 1;
        }
    }
    
    if (progress == 1) {
        _currentIndex = targetIndex;
    }
    
    // 告诉外部滑到的位置
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageContentView:progress:originalIndex:targetIndex:)]) {
        [self.delegate pageContentView:self progress:progress originalIndex:originalIndex targetIndex:targetIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 告诉外部滑到的位置
    NSInteger targetIndex = roundf(scrollView.contentOffset.x/self.width);
    _currentIndex = targetIndex;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageContentView:targetIndex:)]) {
        [self.delegate pageContentView:self targetIndex:targetIndex];
    }
    
}

//响应事件
#pragma mark <----event response---->




//私有方法
#pragma mark <----custom methor---->
- (void)setPageCententViewCurrentIndex:(NSInteger)currentIndex{
    self.isClickBtn = YES;
    _currentIndex = currentIndex;
    CGFloat offsetX = currentIndex * self.collectionView.width;
    self.collectionView.contentOffset = CGPointMake(offsetX, 0);
}

- (void)scrollsToTop:(BOOL)top{
    self.collectionView.scrollsToTop = top;
}


//属性方法
#pragma mark <----getter、setter---->

- (void)setIs_scroll:(BOOL)is_scroll
{
    _is_scroll = is_scroll;
    _collectionView.scrollEnabled = is_scroll;
}

- (NSArray *)childMainViews{
    if (!_childMainViews) {
        _childMainViews = [[NSArray alloc] init];
    }
    return _childMainViews;
}


- (NSArray *)chileMainHeaderViews{
    if (!_chileMainHeaderViews) {
        _chileMainHeaderViews = [[NSArray alloc] init];
    }
    return _chileMainHeaderViews;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(self.width, self.height);
        CGFloat collectionViewX = 0;
        CGFloat collectionViewY = 0;
        CGFloat collectionViewW = self.width;
        CGFloat collectionViewH = self.height;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:flowLayout];
        _collectionView.allowsSelection = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

@end
