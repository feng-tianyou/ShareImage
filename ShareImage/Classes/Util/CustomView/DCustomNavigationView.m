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
    self.navLeftItem.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 100-leftimgSize.width - 10);
    if (leftimgSize.width == 0) {
        leftimgSize = [self.navLeftItem.titleLabel.text sizeWithFont:DSystemFontText maxWidth:100];
        self.navLeftItem.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 100-leftimgSize.width - 10);
    }
    [self.navLeftItem setFrame:8 y:20 w:100 h:44];
    
    CGSize rightimgSize = self.navRightItem.imageView.image.size;
    self.navRightItem.imageEdgeInsets = UIEdgeInsetsMake(0, 100-rightimgSize.width - 10, 0, 0);
    if (rightimgSize.width == 0) {
        rightimgSize = [self.navRightItem.titleLabel.text sizeWithFont:DSystemFontText maxWidth:100];
        self.navRightItem.titleEdgeInsets = UIEdgeInsetsMake(0, 100-rightimgSize.width - 10, 0, 0);
    }
    [self.navRightItem setFrame:(self.width - 100 - 10) y:20 w:100 h:44];
    
    [self.navTitleItem setFrame:self.navLeftItem.right y:20 w:(self.width - 8 - 100 - 10 - 100) h:44];
    
}


#pragma mark - getter & setter
- (UIButton *)navLeftItem{
    if (!_navLeftItem) {
        _navLeftItem = [[UIButton alloc] init];
        _navLeftItem.contentMode = UIViewContentModeLeft;
        _navLeftItem.titleLabel.textAlignment = NSTextAlignmentLeft;
        _navLeftItem.titleLabel.font = DSystemFontText;
    }
    return _navLeftItem;
}

- (UIButton *)navRightItem{
    if (!_navRightItem) {
        _navRightItem = [[UIButton alloc] init];
        _navRightItem.titleLabel.textAlignment = NSTextAlignmentRight;
        _navRightItem.contentMode = UIViewContentModeRight;
        _navRightItem.titleLabel.font = DSystemFontText;
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
