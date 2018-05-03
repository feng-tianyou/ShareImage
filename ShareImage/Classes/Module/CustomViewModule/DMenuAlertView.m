//
//  DMenuAlertView.m
//  DFrame
//
//  Created by DaiSuke on 16/9/13.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DMenuAlertView.h"
#import "DImageTextButton.h"

@interface DMenuAlertView ()


@property (strong, nonatomic) UIScrollView *bgView;
@property (strong, nonatomic) UIImageView *arrowView;

@property (strong, nonatomic) NSMutableArray *leftImageArr;
@property (strong, nonatomic) NSMutableArray *rightTitleArr;
@property (assign, nonatomic) CGFloat viewWidth;
@property (assign, nonatomic) CGFloat viewHieght;
@property (assign, nonatomic) NSInteger viewType;

@end

@implementation DMenuAlertView

- (NSMutableArray *)leftImageArr{
    if (!_leftImageArr) {
        _leftImageArr = [NSMutableArray array];
    }
    return _leftImageArr;
}

- (NSMutableArray *)rightTitleArr{
    if (!_rightTitleArr) {
        _rightTitleArr = [NSMutableArray array];
    }
    return _rightTitleArr;
}

- (UIScrollView *)bgView{
    if (!_bgView) {
        _bgView = [[UIScrollView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        [_bgView.layer setCornerRadius:2.0];
        [_bgView.layer setMasksToBounds:YES];
    }
    return _bgView;
}

- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_triangle_up"]];
    }
    return _arrowView;
}

- (instancetype)initWithType:(DMenuAlertViewDirectionType)type{
    self = [super init];
    if (self) {
        _viewType = type;
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.arrowView];
    [self addSubview:self.bgView];
    
    [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    [self hide];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

#pragma mark - 私有
- (void)creatBtn{
    
    [self hide];
    CGFloat height = 0;
    __weak DMenuAlertView *weakSelf = self;
    BOOL isLeftMax = self.leftImageArr.count > self.rightTitleArr.count ? YES : NO;
    if (isLeftMax) {
        [self.leftImageArr enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                DImageTextButton *button = [[DImageTextButton alloc] init];
                button.tag = idx;
                button.imgView.image = [UIImage imageNamed:imageName];
                if (idx < weakSelf.rightTitleArr.count) {
                    button.lblTitle.text = [weakSelf.rightTitleArr objectAtIndex:idx];
                }
                [button setFrame:CGRectMake(0, idx*weakSelf.viewHieght+1, weakSelf.viewWidth, weakSelf.viewHieght)];
                [button addTarget:weakSelf action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
                
                if (idx < (weakSelf.leftImageArr.count - 1)) {
                    UILabel *line = [[UILabel alloc] init];
                    line.backgroundColor = [UIColor whiteColor];
                    line.alpha = 0.2;
                    line.frame = CGRectMake(10, CGRectGetMaxY(button.frame)+1, weakSelf.viewWidth-20, 1);
                    [weakSelf.bgView addSubview:line];
                }
                [weakSelf.bgView addSubview:button];
            }
        }];
        height = _leftImageArr.count * (self.viewHieght+1)-1;
        
    } else {
        [_rightTitleArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                DImageTextButton *button = [[DImageTextButton alloc] init];
                button.tag = idx;
                button.lblTitle.text = title;
                if (idx < weakSelf.leftImageArr.count) {
                    button.imgView.image = [UIImage imageNamed:[weakSelf.leftImageArr objectAtIndex:idx]];
                }
                [button setFrame:CGRectMake(0, idx*weakSelf.viewHieght+1, weakSelf.viewWidth, weakSelf.viewHieght)];
                [button addTarget:weakSelf action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
                
                if (idx < (weakSelf.rightTitleArr.count - 1)) {
                    UILabel *line = [[UILabel alloc] init];
                    line.backgroundColor = [UIColor whiteColor];
                    line.alpha = 0.2;
                    line.frame = CGRectMake(10, CGRectGetMaxY(button.frame)+1, weakSelf.viewWidth-20, 1);
                    [weakSelf.bgView addSubview:line];
                }
                [weakSelf.bgView addSubview:button];
            }
        }];
        height = self.rightTitleArr.count * (self.viewHieght+1)-1;
    }
    
    
    
    switch (self.viewType) {
            case DMenuAlertViewDirectionTopRightType:
        {
            self.arrowView.frame = CGRectMake(self.frame.size.width - 30, 10, 10, 10);
            self.bgView.frame = CGRectMake((self.frame.size.width - _viewWidth - 10), CGRectGetMaxY(self.arrowView.frame), _viewWidth, height);
        }
            break;
            case DMenuAlertViewDirectionTopLeftType:
        {
            self.arrowView.frame = CGRectMake(20, 10, 10, 10);
            self.bgView.frame = CGRectMake(10, CGRectGetMaxY(self.arrowView.frame), _viewWidth, height);
        }
            break;
            case DMenuAlertViewDirectionBotomLeftType:
        {
            self.arrowView.frame = CGRectMake(20, (self.frame.size.height-10-10), 10, 10);
            self.bgView.frame = CGRectMake(10, (self.frame.size.height - 10 - 10 - height), _viewWidth, height);
        }
            break;
            case DMenuAlertViewDirectionBotomRightType:
        {
            self.arrowView.frame = CGRectMake(self.frame.size.width - 30, (self.frame.size.height-10-10), 10, 10);
            self.bgView.frame = CGRectMake((self.frame.size.width - _viewWidth - 10), (self.frame.size.height - 10 - 10 - height), _viewWidth, height);
        }
            break;
            
        default:
            break;
    }
    
    self.bgView.contentSize = CGSizeMake(_viewWidth, height);
}

- (void)clickItem:(DImageTextButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuAlertView:didSelectIndex:)]) {
        [self.delegate menuAlertView:self didSelectIndex: button.tag];
    }
}



#pragma mark - 暴露方法
- (void)setTitleArrary:(NSArray *)titleArr viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight{
    [self setLeftImageArrary:nil rightTitleArrary:titleArr viewWidth:viewWidth viewHeight:viewHeight];
}
- (void)setLeftImageArrary:(NSArray *)leftImageArr rightTitleArrary:(NSArray *)rightTitleArr viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight{
    if (leftImageArr.count > 0) {
        self.leftImageArr = [NSMutableArray arrayWithArray:leftImageArr];
    }
    
    if (rightTitleArr.count > 0) {
        self.rightTitleArr = [NSMutableArray arrayWithArray:rightTitleArr];
    }
    
    self.viewWidth = viewWidth;
    self.viewHieght = viewHeight;
    
    [self creatBtn];
}


- (void)show{
    if(!self.hidden){
        [self hide];
        return;
    }
    
    [self setHidden:NO];
    [self setAlpha:1.0];
    CAKeyframeAnimation *animationPath = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef aPath = CGPathCreateMutable();
    CGFloat x = self.frame.size.width/2.0;
    CGFloat y = self.frame.size.height/2.0;
    if (self.viewType == DMenuAlertViewDirectionTopLeftType || self.viewType == DMenuAlertViewDirectionTopRightType) {
        
        CGPathMoveToPoint(aPath, nil, x, 0);
        CGPathAddCurveToPoint(aPath, nil, x, y - 80, x, y - 20, x, y);
        
    } else {
        
        CGPathMoveToPoint(aPath, nil, x, self.frame.size.height);
        CGPathAddCurveToPoint(aPath, nil, x, y + 20, x, y + 80, x, y);
        
    }
    animationPath.path = aPath;
    animationPath.duration = 0.2;
    animationPath.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animationPath forKey:@"position"];
    CGPathRelease(aPath);
    
}

- (void)hide{
    [self setAlpha:1.0];
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}

- (void)setType:(DMenuAlertViewDirectionType)type{
    _type = type;
    self.viewType = type;
}

- (void)setCustomView:(UIView *)customView{
    _customView = customView;
    [self.bgView addSubview:customView];
    CGRect rect = customView.frame;
    switch (self.viewType) {
            case DMenuAlertViewDirectionTopRightType:
        {
            self.arrowView.frame = CGRectMake(self.frame.size.width - 30, 10, 10, 10);
            self.bgView.frame = CGRectMake((self.frame.size.width - rect.size.width - 10), CGRectGetMaxY(self.arrowView.frame), rect.size.width, rect.size.height);
        }
            break;
            case DMenuAlertViewDirectionTopLeftType:
        {
            self.arrowView.frame = CGRectMake(20, 10, 10, 10);
            self.bgView.frame = CGRectMake(10, CGRectGetMaxY(self.arrowView.frame), rect.size.width, rect.size.height);
        }
            break;
            case DMenuAlertViewDirectionBotomLeftType:
        {
            self.arrowView.frame = CGRectMake(20, (self.frame.size.height-10-10), 10, 10);
            self.bgView.frame = CGRectMake(10, (self.frame.size.height - 10 - 10 - rect.size.height), _viewWidth, rect.size.height);
        }
            break;
            case DMenuAlertViewDirectionBotomRightType:
        {
            self.arrowView.frame = CGRectMake(self.frame.size.width - 30, (self.frame.size.height-10-10), 10, 10);
            self.bgView.frame = CGRectMake((self.frame.size.width - rect.size.width - 10), (self.frame.size.height - 10 - 10 - rect.size.height), rect.size.width, rect.size.height);
        }
            break;
            
        default:
            break;
    }
    self.bgView.contentSize = CGSizeMake(rect.size.width, rect.size.height);
}


@end
