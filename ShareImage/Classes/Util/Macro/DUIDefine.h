//
//  DUIDefine.h
//  DFrame
//
//  Created by DaiSuke on 16/8/29.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#ifndef DUIDefine_h
#define DUIDefine_h

#pragma mark - 屏幕
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark - iOS版本
// iOS6
#define IOS6 ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0)
// iOS7
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// iOS8
#define IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
// iOS9
#define IOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
// iOS10
#define IOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)


#pragma mark - 颜色管理
// 取RGB颜色
#define DColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define UIColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]
#define DUIColorFromRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DUIColorFromRGB(_color, _alpha)  [DCommonTool TColor:_color colorAlpha:_alpha]


// gray
#define DSystemColorGrayE0E0E0      DUIColorFromRGB16(0xe0e0e0)
#define DSystemColorGrayF3F3F3      DUIColorFromRGB16(0xf3f3f3)
#define DSystemColorGray999999      DUIColorFromRGB16(0x999999)

// black
#define DSystemColorBlackBBBBBB     DUIColorFromRGB16(0xbbbbbb)
#define DSystemColorBlack333333     DUIColorFromRGB16(0x333333)


//一级颜色
#define DSystemColorBlue           DUIColorFromRGB16(0x1177ff) //可点击的文字
#define DSystemColorRed            DUIColorFromRGB16(0xc20000) //重点、错误
#define DSystemColorOranger        DUIColorFromRGB16(0xff5500) //提示
#define DSystemColorGreen          DUIColorFromRGB16(0x339900) //通行允许
#define DSystemColorGray           DUIColorFromRGB16(0xaaaaaa) //辅助文字
#define DSystemColorYellow         DUIColorFromRGB16(0xfff8da) //提示背景
#define DSystemColorYellowTink     DUIColorFromRGB16(0xff5500)
#define DSystemColorRedTink        DUIColorFromRGB16(0xf7dede) //断网提示

#pragma mark - 字体管理
// =============================字体大小=============================  //
#define DSystemFontNavigationBar   [UIFont boldSystemFontOfSize:18]//导航栏标题
#define DSystemFontTitle           [UIFont systemFontOfSize:16]//一级标题
#define DSystemFontText            [UIFont systemFontOfSize:15]//正文
#define DSystemFontContent         [UIFont systemFontOfSize:14]//内容
#define DSystemFontAlert           [UIFont systemFontOfSize:14]//提醒
#define DSystemFontDate            [UIFont systemFontOfSize:13]//时间

#define DSystemFontTitleBold       [UIFont boldSystemFontOfSize:16]//一级标题
#define DSystemFontTextBold        [UIFont boldSystemFontOfSize:15]//正文
#define DSystemFontContentBold     [UIFont boldSystemFontOfSize:14]//内容


#define DUIFontFormSize(_fontSize)       [UIFont systemFontOfSize:_fontSize] //默认字体格式
#define DUIFontBoldFormSize(_fontSize)   [UIFont boldSystemFontOfSize:_fontSize] //加粗
#define DUIFontItalicFormSize(_fontSize) [UIFont italicSystemFontOfSize:_fontSize] //斜体




#endif /* DUIDefine_h */
