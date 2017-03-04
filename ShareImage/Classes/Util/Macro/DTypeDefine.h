//
//  DTypeDefine.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#ifndef DTypeDefine_h
#define DTypeDefine_h

@class DError, DJsonModel;

typedef void (^VoidBlock)(void);
typedef void (^BoolBlock)(BOOL isTrue);
typedef void (^LongLongBlock)(long long num);
typedef void (^UidAndNameBlock)(long long uid,NSString *name);
typedef void (^NSIntegerBlock)(NSInteger integer);
typedef void (^NSStringBlock)(NSString *str);
typedef void (^NSDictionaryBlock)(NSDictionary *dic);
typedef void (^NSObjectBlock)(id responseObject);
typedef void (^NSObjectForCacheBlock)(id responseObject,BOOL isCache);
typedef void (^NSDictionaryForCacheBlock)(NSDictionary *dic,BOOL isCache);
typedef void (^NSArrayForCacheBlock)(NSArray *arr,BOOL isCache);
typedef void (^NSArrayBlock)(NSArray *arr);
typedef void (^UIImageBlock)(UIImage *img);
typedef void (^SqliteArrayBlock)(BOOL isSuccess, NSArray *modelArray);
typedef void (^ErrorBlockWithSendData)(NSString *idNum);
typedef void (^JsonModelBlock)(__kindof DJsonModel *model);
typedef void (^ErrorBlock)(DError *error);

typedef NS_ENUM(NSInteger, DAppBgType) {
    DAppBgTypeDefault,
    DAppBgTypeNight    // 夜间
    
};


typedef NS_ENUM(NSInteger, DNavigationItemType) {
    
    // ========== NO ============ //
    DNavigationItemTypeNone,
    DNavigationItemTypeBack,
    DNavigationItemTypeWriteBack,
    
    // ========== 图片 ============ //
    DNavigationItemTypeRightSearch,//右边 搜索
    DNavigationItemTypeRightMenu,//右边 菜单
    DNavigationItemTypeRightWriteMenu,//右边 菜单
    
    // ========== 文字 ============ //
    DNavigationItemTypeBackHome,//返回 首页
    DNavigationItemTypeRightHome,//右边 首页
    DNavigationItemTypeRightSend,//右边 提交
    DNavigationItemTypeRightSave,//右边 保存
    DNavigationItemTypeRightClear,//右边 清空
    DNavigationItemTypeRightNext, // 右边 下一步
    DNavigationItemTypeRightPublic,//右边 发布
    DNavigationItemTypeRightCancel,//右边 取消
    DNavigationItemTypeRightFinish,//右边 完成
    DNavigationItemTypeRightFeedback,//右边 意见反馈
    DNavigationItemTypeRightSetting, // 右边 设置
    
};

typedef NS_ENUM(NSInteger,DeviceType) {
    DeviceTypeFor5SAndAbove = 1,
    DeviceTypeFor6,
    DeviceTypeFor6p,
};

typedef NS_ENUM(NSInteger,LogoutType) {
    LogoutTypeForNoValid = 1,
    LogoutTypeForNoOAuth,  // 没有授权
    LogoutTypeForOther,
};


typedef NS_ENUM(NSInteger, LoginPlatformType) {
    LoginPlatformType_Sina = 1, //新浪
    LoginPlatformType_Wechat, //微信
    LoginPlatformType_QQ,//QQ
};

typedef NS_ENUM(NSInteger,CacheType) {
    CacheTypeForImageNormal = 1,
    CacheTypeForImageUserIcon,
    CacheTypeForAudio,
    CacheTypeForJson,
    CacheTypeForPlist
};

typedef NS_ENUM(NSInteger,FileState)
{
    FileCreateSuccess = 1,
    FileExist,
    FileNoExist,
    FileOpenSuccess,
    FileWriteSuccess,
    FileDeleteSuccess,
    FileError
};

typedef NS_ENUM(NSInteger, SearchType) {
    PhotoSearchType,
    UserSearchType,
    CollectionSearchType,
    OtherSearchType
};


typedef NS_ENUM(NSInteger,ErrorType) {
    
    ErrorTypeForAlertResetPassword = 1,//提示跳转至忘记密码页面
    
    
};

#endif /* DTypeDefine_h */
