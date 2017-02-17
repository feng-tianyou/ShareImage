//
//  DUserService.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DUserService.h"

// network
#import "DUserNetwork.h"

@interface DUserService ()
{
    NSMutableDictionary *_dicUserInfo;
}
@property (nonatomic, strong) DUserNetwork *userNetwork;

@end

@implementation DUserService

- (DUserNetwork *)userNetwork{
    if(_userNetwork == nil){
        _userNetwork = [DUserNetwork shareEngine];
    }
    _userNetwork.userInfoForCancelTask = _dicUserInfo;
    return _userNetwork;
}

- (void)oauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel
                     onSucceeded:(JsonModelBlock)succeededBlock
                         onError:(ErrorBlock)errorBlock{
    
    [self.network oauthAccountByParamModel:paramModel onSucceeded:^(id responseObject) {
        DLog(@"%@",responseObject);
        DOAuthAccountModel *model = [DOAuthAccountModel modelWithJSON:responseObject];
        
        KGLOBALINFOMANAGER.accessToken = model.access_token;
        KGLOBALINFOMANAGER.refreshToken = model.refresh_token;
        
        // 归档
        [DOAuthAccountTool saveAccount:model];
        
        [DBlockTool executeModelBlock:succeededBlock model:model];
    } onError:errorBlock];
}


/**
 *  获取用户信息
 *
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
-(void)getAccountByOnSucceeded:(JsonModelBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock{
    [self.network getAccountNeedCache:YES onSucceeded:^(NSDictionary *dic) {
        if (RESPONSESUCCESS) {
            NSDictionary *dicData = [dic objectForKey:kParamData];
            DUserModel *userModel = [[DUserModel alloc] initWithDictionary:dicData];
            [DBlockTool executeModelBlock:succeededBlock model:userModel];
        }
    } onError:errorBlock];
}

/**
 *  获取用户信息(不使用缓存)
 *
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
-(void)getAccountWithNotCacheByOnSucceeded:(JsonModelBlock)succeededBlock onError:(ErrorBlock)errorBlock{
    [self.network getAccountNeedCache:NO onSucceeded:^(NSDictionary *dic) {
        if (RESPONSESUCCESS) {
            NSDictionary *dicData = [dic objectForKey:kParamData];
            DUserModel *userModel = [[DUserModel alloc] initWithDictionary:dicData];
            [DBlockTool executeModelBlock:succeededBlock model:userModel];
        }
    } onError:errorBlock];
}

@end
