//
//  DSelectItemView.m
//  InformationProject
//
//  Created by FTY on 2017/9/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSelectItemView.h"

@interface DSelectItemView()
{
    NSArray *_titles;
    NSMutableArray *_items;
    UIView *_moveLine;
    UIView *_line;
    LineType _lineType;
}
@end

@implementation DSelectItemView

///生命周期
#pragma mark <----life cycle---->

- (instancetype)initWithTitles:(NSArray *)titles{
    return [self initWithTitles:titles lineType:LineTypeForFit selectIndex:0];
}

- (instancetype)initWithTitles:(NSArray *)titles lineType:(LineType)lineType{
    return [self initWithTitles:titles lineType:lineType selectIndex:0];
}

- (instancetype)initWithTitles:(NSArray *)titles lineType:(LineType)lineType selectIndex:(NSInteger)selectIndex{
    if(self = [super initWithFrame:CGRectZero]){
        _titles = titles;
        _lineType = lineType;
        _selectIndex = selectIndex;
        [self proccessData];
        [self proccessView];
    }
    return self;
}

- (void)proccessData{
    
    self.backgroundColor = DSystemColorWhite;
    _items = [NSMutableArray array];
}

- (void)proccessView{
    
    for (int i = 0; i < _titles.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitle:_titles[i] forState:UIControlStateHighlighted];
        [btn setTitleColor:DSystemColorGray666666 forState:UIControlStateNormal];
        [btn setTitleColor:DSystemColorGray666666 forState:UIControlStateHighlighted];
        [btn setTitleColor:DSystemColorBlack333333 forState:UIControlStateSelected];
        btn.titleLabel.font = DSystemFontText;
        btn.tag = i;
        if (i == _selectIndex) {
            btn.selected = YES;
        }
        btn.backgroundColor = DSystemColorWhite;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_items addObject:btn];
        [self addSubview:btn];
    }
    
    _moveLine = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = DSystemColorBlack333333;
        view;
    });
    [self addSubview:_moveLine];
    
    _line = ({
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = DSystemColorBlacke3e3e3;
        line;
    });
    [self addSubview:_line];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat itemWidth = self.width/_items.count;
    
    for (int i = 0; i < _items.count; i++) {
        UIButton *btn = _items[i];
        [btn setFrame:i * itemWidth y:0 w:itemWidth h:self.height];
    }
    [_line setFrame:0 y:self.height - LineWidth w:self.width h:LineWidth];
    
    // 获取选中按钮
    UIButton *btn = [_items firstObject];
    if (_items.count > _selectIndex) {
        btn = [_items objectAtIndex:_selectIndex];
    }
    
    // 设置移动线条的frame
    if (btn.selected) {
        if (_lineType == LineTypeForFit) {
            CGFloat itemTitleWidth = [btn.currentTitle sizeWithFont:btn.titleLabel.font maxWidth:itemWidth].width;
            itemTitleWidth += 20;
            [_moveLine setFrame:btn.x + (itemWidth - itemTitleWidth)/2 y:self.height - LineWidth - 2 w:itemTitleWidth h:2];
        } else if (_lineType == LineTypeForFull){
            [_moveLine setFrame:btn.x y:self.height - LineWidth - 2 w:itemWidth h:2];
        }
    }
}


//代理方法
#pragma mark <----Delegate---->



//响应事件
#pragma mark <----event response---->
- (void)clickBtn:(UIButton *)btn{
    for (UIButton *item in _items) {
        if ([item isEqual:btn]) {
            item.selected = YES;
        } else {
            item.selected = NO;
        }
        
    }
    [UIView animateWithDuration:0.25 delay:.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (_lineType == LineTypeForFit) {
            CGFloat itemTitleWidth = [btn.currentTitle sizeWithFont:btn.titleLabel.font maxWidth:btn.width].width;
            itemTitleWidth += 20;
            CGFloat x = btn.tag * btn.width;
            CGFloat moveX = x + (btn.width - itemTitleWidth)/2;
            _moveLine.x = moveX;
            _moveLine.width = itemTitleWidth;
        } else if (_lineType == LineTypeForFull){
            _moveLine.x = btn.tag * btn.width;
        }
    } completion:^(BOOL finished) {
        
    }];
    
    ExistActionDo(self.clickItemBlock, self.clickItemBlock(btn.tag));
}



//私有方法
#pragma mark <----custom methor---->




//属性方法
#pragma mark <----getter、setter---->
- (void)setItemHighLightColor:(UIColor *)itemHighLightColor{
    _itemHighLightColor = itemHighLightColor;
    for (UIButton *btn in _items) {
        [btn setTitleColor:itemHighLightColor forState:UIControlStateSelected];
    }
}

- (void)setMoveLineColor:(UIColor *)moveLineColor{
    _moveLineColor = moveLineColor;
    _moveLine.backgroundColor = moveLineColor;
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    if (selectIndex < _items.count)
    {
        UIButton *btn = _items[selectIndex];
        for (UIButton *item in _items) {
            if ([item isEqual:btn]) {
                item.selected = YES;
            } else {
                item.selected = NO;
            }
            
        }
        [UIView animateWithDuration:0.25 delay:.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (_lineType == LineTypeForFit) {
                CGFloat itemTitleWidth = [btn.currentTitle sizeWithFont:btn.titleLabel.font maxWidth:btn.width].width;
                itemTitleWidth += 20;
                CGFloat x = btn.tag * btn.width;
                CGFloat moveX = x + (btn.width - itemTitleWidth)/2;
                _moveLine.x = moveX;
                _moveLine.width = itemTitleWidth;
            } else if (_lineType == LineTypeForFull){
                _moveLine.x = btn.tag * btn.width;
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
