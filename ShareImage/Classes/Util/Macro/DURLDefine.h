//
//  DURLDefine.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#ifndef DURLDefine_h
#define DURLDefine_h

//#define kHttpURL        @"http://api.ywq.t.tgnet.com"
//#define kHttpURL        @"http://api.ywq.tgnet.com"

#ifdef  DEBUG   //DeBug版本宏

//#define kHttpURL        @"测试地址"
#define kHttpURL        @"http://api.ywq.t.tgnet.com"

#else           //Release版本宏（发布版本）

#define kHttpURL        @"发布的"

#endif


/********************************************** 请求方法 **********************************************/

#define kHttpMethorGet      @"GET"//获取
#define kHttpMethorPut      @"PUT"//编辑
#define kHttpMethorPost     @"POST"//上传
#define kHttpMethorDelete   @"DELETE"//删除

/********************************************** 授权接口 **********************************************/

#define kPathToken          @"/Token" //获取授权码
#define kPathTokenActual    @"/Token/Actual" //获取授权期间［GET:获取或POST:提交］用户真实资料
#define kPathTokenVerify    @"/Token/Verify" //获取授权期间［GET:获取或POST:提交］手机验证码
#define kPathTokenLogout    @"/Token/logout"
#define kPathGrant          @"Api/Grant" //获取授权码

/********************************************** 账号接口 **********************************************/

#define kPathAccount        @"/Api/Account" //GET:获取用户资料 POST：注册  PUT:修改用户资料


//LoginNetwork
/********************************************** LoginNetwork **********************************************/

#define kPathTokenIndex     @"/Token/Index" //获取授权码


#endif /* DURLDefine_h */
