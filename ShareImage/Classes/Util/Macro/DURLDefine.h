//
//  DURLDefine.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#ifndef DURLDefine_h
#define DURLDefine_h

#ifdef  DEBUG   //DeBug版本宏

#define kHttpURL        @"https://api.unsplash.com"

#else           //Release版本宏（发布版本）

#define kHttpURL        @"https://api.unsplash.com"

#endif


/********************************************** 请求方法 **********************************************/

#define kHttpMethorGet      @"GET"//获取
#define kHttpMethorPut      @"PUT"//编辑
#define kHttpMethorPost     @"POST"//上传
#define kHttpMethorDelete   @"DELETE"//删除




#endif /* DURLDefine_h */
