//
//  DCustomNavigationView.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/5.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCustomNavigationView.h"
#import "DNavigationTool.h"

@implementation DCustomNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.navLeftItem];
        [self addSubview:self.navTitleItem];
        [self addSubview:self.navRightItem];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize leftimgSize = self.navLeftItem.imageView.image.size;
    [self.navLeftItem setFrame:8 y:(self.height - leftimgSize.height - 10) w:leftimgSize.width h:leftimgSize.height];
    
    CGSize rightimgSize = self.navRightItem.imageView.image.size;
    [self.navRightItem setFrame:(self.width - rightimgSize.width - 10) y:self.navLeftItem.y w:rightimgSize.width h:rightimgSize.height];
    
    [self.navTitleItem setFrame:self.navLeftItem.right y:(self.height - 30) w:(self.width - 8 - leftimgSize.width - 10 - rightimgSize.width) h:20];
    
}


#pragma mark - getter & setter
- (UIButton *)navLeftItem{
    if (!_navLeftItem) {
        _navLeftItem = [[UIButton alloc] init];
        _navLeftItem.titleLabel.textAlignment = NSTextAlignmentLeft;
        _navLeftItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _navLeftItem;
}

- (UIButton *)navRightItem{
    if (!_navRightItem) {
        _navRightItem = [[UIButton alloc] init];
        _navRightItem.titleLabel.textAlignment = NSTextAlignmentRight;
        _navRightItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _navRightItem;
}

- (UIButton *)navTitleItem{
    if (!_navTitleItem) {
        _navTitleItem = [[UIButton alloc] init];
        _navTitleItem.titleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleItem.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [_navTitleItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _navTitleItem;
}

- (void)setNavLeftItemType:(DNavigationItemType)navLeftItemType{
    _navLeftItemType = navLeftItemType;
    [self setNavType:navLeftItemType button:self.navLeftItem];
}

- (void)setNavRighItemType:(DNavigationItemType)navRighItemType{
    _navRighItemType = navRighItemType;
    [self setNavType:navRighItemType button:self.navRightItem];
}


- (void)setNavType:(DNavigationItemType)type button:(UIButton *)button{
    switch (type) {
        case DNavigationItemTypeNone:{
            break;
        }
        case DNavigationItemTypeBack:
        case DNavigationItemTypeWriteBack:
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
        case DNavigationItemTypeRightSetting:
        case DNavigationItemTypeRightMenu:
        case DNavigationItemTypeRightWriteMenu:
        case DNavigationItemTypeRightSearch:{
            
            NSString *strTitle = [DNavigationTool getNavigationBarRightTitleByType:type];
            UIImage *img = [DNavigationTool getNavigationBarRightImgByType:type];
            
            CGSize size = CGSizeZero;
            if (strTitle.length > 0) {
                button.titleLabel.textAlignment = NSTextAlignmentCenter;
                size = [strTitle sizeWithFont:[UIFont systemFontOfSize:15.0] maxWidth:MAXFLOAT];
                [button setTitle:strTitle forState:UIControlStateNormal];
                [button setTitle:strTitle forState:UIControlStateHighlighted];
                [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
                [button.titleLabel setTextColor:[UIColor whiteColor]];
            }
            
            if (img) {
                size = img.size;
                button.contentMode = UIViewContentModeCenter;
                [button setImage:img forState:UIControlStateNormal];
                [button setImage:img forState:UIControlStateHighlighted];
            }
            break;
        }
    }
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    [self.navTitleItem setTitle:title forState:UIControlStateNormal];
}

@end
