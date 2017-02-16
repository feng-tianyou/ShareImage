//
//  DLoginValidRule.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DLoginValidRule.h"

#define TEXT_USERNO_NIL         @"请输入帐号"
#define TEXT_PSW_NIL            @"请输入密码"
#define TEXT_PSW_ALERT          @"密码不能少于6位"
#define TEXT_USERNO_NOVAILD     @"您输入的帐号不存在，\n请检查是否输入有误"
#define TEXT_USERNO_PSW_ALERT   @"您输入的帐号或密码有误，\n请重新输入"
#define TEXT_MOBILE_NIL         @"手机号码不能为空"
#define TEXT_TYPE_NIL           @"验证码类型不能为空"
#define TEXT_CODE_NIL           @"请输入验证码"
#define TEXT_PSW_LENGTH_LESS    @"密码长度不正确，密码长度应该为6-20位字符"
#define TEXT_NAME_NIL           @"真实姓名不能为空"
#define TEXT_COMPANY_NIL        @"公司全称不能为空"
#define TEXT_CHECK_PSW_NIL      @"请再次输入密码"
#define TEXT_PSD_NOT_SAME       @"两次输入的密码不一致"

@implementation DLoginValidRule

+ (NSString *)checkParamIsValidForLoginByParamModel:(id<DLoginParamProtocol>)paramModel{
    
    if(paramModel.userNo.length <= 0){
        return TEXT_USERNO_NIL;
    }
    
    if(paramModel.password.length <= 0){
        return TEXT_PSW_NIL;
    }
    
    if(paramModel.password.length < 6 || paramModel.password.length > 20){
        return TEXT_PSW_ALERT;
    }
    
    return @"";
}

@end
