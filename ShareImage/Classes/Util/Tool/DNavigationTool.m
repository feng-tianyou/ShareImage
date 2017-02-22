//
//  DNavigationTool.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DNavigationTool.h"

#define D_NAVIGATION_BAR_LEFT_BACK_BG_IMAGE_NAME        @"navigationbar_btn_left"

#define D_NAVIGATION_BAR_RIGHT_MENU_BG_IMAGE_NAME        @"navigationbar_btn_right_menu"
#define D_NAVIGATION_BAR_RIGHT_SHEARCH_BG_IMAGE_NAME        @"navigationbar_btn_left_search"


#define D_NAVIGATION_BAR_TEXT_LEFT_BACK           @"返回"
#define D_NAVIGATION_BAR_TEXT_LEFT_BACK_HOME      @"首页"
#define D_NAVIGATION_BAR_TEXT_RIGHT_HOME          @"首页"
#define D_NAVIGATION_BAR_TEXT_RIGHT_SEND          @"提交"
#define D_NAVIGATION_BAR_TEXT_RIGHT_SAVE          @"保存"
#define D_NAVIGATION_BAR_TEXT_RIGHT_CLEAR         @"清空"
#define D_NAVIGATION_BAR_TEXT_RIGHT_NEXT          @"下一步"
#define D_NAVIGATION_BAR_TEXT_RIGHT_PUBLIC        @"发布"
#define D_NAVIGATION_BAR_TEXT_RIGHT_CANCEL        @"取消"
#define D_NAVIGATION_BAR_TEXT_RIGHT_FINISH        @"完成"
#define D_NAVIGATION_BAR_TEXT_RIGHT_FEEDBACK      @"意见反馈"
#define D_NAVIGATION_BAR_TEXT_RIGHT_SETTING       @"设置"

@implementation DNavigationTool

+ (NSString *)getNavigationBarRightTitleByType:(DNavigationItemType)type{
    NSString *strTitle = @"";
    switch (type) {
        case DNavigationItemTypeBackHome:{
            strTitle = D_NAVIGATION_BAR_TEXT_LEFT_BACK_HOME;
            break;
        }
        case DNavigationItemTypeRightHome:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_HOME;
            break;
        }
        case DNavigationItemTypeRightSend:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_SEND;
            break;
        }
        case DNavigationItemTypeRightSave:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_SAVE;
            break;
        }
        case DNavigationItemTypeRightClear:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_CLEAR;
            break;
        }
        case DNavigationItemTypeRightNext:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_NEXT;
            break;
        }
        case DNavigationItemTypeRightPublic:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_PUBLIC;
            break;
        }
        case DNavigationItemTypeRightCancel:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_CANCEL;
            break;
        }
        case DNavigationItemTypeRightFinish:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_FINISH;
            break;
        }
        case DNavigationItemTypeRightFeedback:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_FEEDBACK;
            break;
        }
        case DNavigationItemTypeRightSetting:{
            strTitle = D_NAVIGATION_BAR_TEXT_RIGHT_SETTING;
            break;
        }
        default:{
            
            break;
        }
    }
    return strTitle;
}

+ (UIImage *)getNavigationBarRightImgByType:(DNavigationItemType)type{
    UIImage *img = nil;
    switch (type) {
        case DNavigationItemTypeBack:{
            img = [UIImage getImageWithName:D_NAVIGATION_BAR_LEFT_BACK_BG_IMAGE_NAME];
            break;
        }
        case DNavigationItemTypeRightMenu:{
            img = [UIImage getImageWithName:D_NAVIGATION_BAR_RIGHT_MENU_BG_IMAGE_NAME];
            break;
        }
        case DNavigationItemTypeRightSearch:{
            img = [UIImage getImageWithName:D_NAVIGATION_BAR_RIGHT_SHEARCH_BG_IMAGE_NAME];
            break;
        }
        default:{
            
            break;
        }
    }
    return img;
}


@end
