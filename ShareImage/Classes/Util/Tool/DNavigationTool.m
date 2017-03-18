//
//  DNavigationTool.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DNavigationTool.h"

#define D_NAVIGATION_BAR_LEFT_BACK_BG_IMAGE_NAME        @"navigationbar_btn_left"
#define D_NAVIGATION_BAR_LEFT_WRITE_BACK_BG_IMAGE_NAME        @"navigationbar_btn_write_left"

#define D_NAVIGATION_BAR_RIGHT_MENU_BG_IMAGE_NAME        @"navigationbar_btn_right_menu"
#define D_NAVIGATION_BAR_RIGHT_WRITE_MENU_BG_IMAGE_NAME        @"navigationbar_btn_write_menu"
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
            strTitle = kLocalizedLanguage(@"navBack");
            break;
        }
        case DNavigationItemTypeRightHome:{
            strTitle = kLocalizedLanguage(@"navHome");
            break;
        }
        case DNavigationItemTypeRightSend:{
            strTitle = kLocalizedLanguage(@"navSend");
            break;
        }
        case DNavigationItemTypeRightSave:{
            strTitle = kLocalizedLanguage(@"navSave");
            break;
        }
        case DNavigationItemTypeRightClear:{
            strTitle = kLocalizedLanguage(@"navClear");
            break;
        }
        case DNavigationItemTypeRightNext:{
            strTitle = kLocalizedLanguage(@"navNext");
            break;
        }
        case DNavigationItemTypeRightPublic:{
            strTitle = kLocalizedLanguage(@"navPublic");
            break;
        }
        case DNavigationItemTypeRightCancel:{
            strTitle = kLocalizedLanguage(@"navCancel");
            break;
        }
        case DNavigationItemTypeRightFinish:{
            strTitle = kLocalizedLanguage(@"navFinish");
            break;
        }
        case DNavigationItemTypeRightFeedback:{
            strTitle = kLocalizedLanguage(@"navFeedBack");
            break;
        }
        case DNavigationItemTypeRightSetting:{
            strTitle = kLocalizedLanguage(@"navSetting");
            break;
        }case DNavigationItemTypeRightEdit:{
            strTitle = kLocalizedLanguage(@"navEdit");
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
        case DNavigationItemTypeWriteBack:{
            img = [UIImage getImageWithName:D_NAVIGATION_BAR_LEFT_WRITE_BACK_BG_IMAGE_NAME];
            break;
        }
        case DNavigationItemTypeRightWriteMenu:{
            img = [UIImage getImageWithName:D_NAVIGATION_BAR_RIGHT_WRITE_MENU_BG_IMAGE_NAME];
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
