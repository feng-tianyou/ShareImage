//
//  DBaseManager.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseManager.h"
#import "DServiceFactory.h"


@implementation DBaseManager

+ (id)getHTTPManagerByDelegate:(id<DBaseManagerProtocol>)delegate info:(NSMutableDictionary *)info{
    DBaseManager *baseManager = [[self alloc] init];
    baseManager.delegate = delegate;
    baseManager.info = info;
    [kAPPDELEGATE.globalManager addManager:baseManager];
    
    return baseManager;
}

- (id)service{
    if(!_service){
        _service = [DServiceFactory getServiceByManager:self];
    }
    return _service;
}

- (void)addLoadingView{
    
    BOOL addLoading = YES;
    DicHasKeyAndDo(self.info, kParamNoAddLoading, addLoading = [[self.info objectForKey:kParamNoAddLoading] boolValue];)
    if(addLoading){
        DelegateHasMethorAndDoOrLog(self.delegate, addNetworkLoadingViewByText:userInfo:, [self.delegate addNetworkLoadingViewByText:@"Loading..." userInfo:self.info];)
    }
}

- (void)removeLoadingView{
    BOOL isCacheData = NO;
    DicHasKeyAndDo(self.info, kParamCacheData, isCacheData = [[self.info objectForKey:kParamCacheData] boolValue];)
    if(!isCacheData){
        [kAPPDELEGATE.globalManager removeManager:self];
    }
    DelegateHasMethorAndDoOrLog(self.delegate, removeNetworkLoadingView, [self.delegate removeNetworkLoadingView];)
}

- (BOOL)needExecuteClearAndHasNoDataOperationByStart:(NSInteger)start
                                             arrData:(NSArray *)arrData{
    if(start == 1){
        DelegateHasMethorAndDoOrLog(self.delegate, clearData, [self.delegate clearData];)
        [self removeLoadingView];
    }
    
    if(arrData.count == 0){
        if(start == 1){
            DelegateHasMethorAndDoOrLog(self.delegate, alertNoData, [self.delegate alertNoData];)
            return YES;
        }
        DelegateHasMethorAndDoOrLog(self.delegate, hasNotMoreData, [self.delegate hasNotMoreData];)
        return YES;
    }
    return NO;
}


- (void)hasNotMoreData{
    DelegateHasMethorAndDoOrLog(self.delegate, hasNotMoreData, [self.delegate hasNotMoreData];)
}

- (void)requestServiceSucceedByUserInfo{
    [self removeLoadingView];
    DelegateHasMethorAndDoOrLog(self.delegate, requestServiceSucceedByUserInfo:, [self.delegate requestServiceSucceedByUserInfo:self.info];)
}

- (void)requestServiceSucceedBackBool:(BOOL)isTrue{
    [self removeLoadingView];
    DelegateHasMethorAndDoOrLog(self.delegate, requestServiceSucceedBackBool:userInfo:, [self.delegate requestServiceSucceedBackBool:isTrue userInfo:self.info];)
}

- (void)requestServiceSucceedBackString:(NSString *)strData{
    [self removeLoadingView];
    DelegateHasMethorAndDoOrLog(self.delegate, requestServiceSucceedBackString:userInfo:, [self.delegate requestServiceSucceedBackString:strData userInfo:self.info];)
}

- (void)requestServiceSucceedBackLongLongValue:(long long)identityId{
    [self removeLoadingView];
    DelegateHasMethorAndDoOrLog(self.delegate, requestServiceSucceedBackLongLongValue:userInfo:, [self.delegate requestServiceSucceedBackLongLongValue:identityId userInfo:self.info];)
}

- (void)requestServiceSucceedBackArray:(NSArray *)arrData{
    [self removeLoadingView];
    DelegateHasMethorAndDoOrLog(self.delegate, requestServiceSucceedBackArray:userInfo:, [self.delegate requestServiceSucceedBackArray:arrData userInfo:self.info];)
}


- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)model{
    [self removeLoadingView];
    DelegateHasMethorAndDoOrLog(self.delegate, requestServiceSucceedWithModel:userInfo:, [self.delegate requestServiceSucceedWithModel:model userInfo:self.info];)
    
}

- (void)requestServiceSucceedBackErrorType:(ErrorType)errorType{
    [self removeLoadingView];
    DelegateHasMethorAndDoOrLog(self.delegate, requestServiceSucceedBackErrorType:userInfo:, [self.delegate requestServiceSucceedBackErrorType:errorType userInfo:self.info];)
}

- (void)requestServiceSucceedBackErrorType:(ErrorType)errorType result:(id)result{
    [self removeLoadingView];
    DelegateHasMethorAndDoOrLog(self.delegate, requestServiceSucceedBackErrorType:result:userInfo:, [self.delegate requestServiceSucceedBackErrorType:errorType result:result userInfo:self.info];)
}

- (void)localError:(NSString *)text{
    DLocalError *localError = [[DLocalError alloc] initWithAlertFor2Second:NO
                                                               titleText:@""
                                                               alertText:text];
    DelegateHasMethorAndDoOrLog(self.delegate, localError:userInfo:, [self.delegate localError:localError userInfo:self.info];)
}

- (void)localErrorFor2Second:(NSString *)text{
    DLocalError *localError = [[DLocalError alloc] initWithAlertFor2Second:YES
                                                               titleText:@""
                                                               alertText:text];
    DelegateHasMethorAndDoOrLog(self.delegate, localError:userInfo:, [self.delegate localError:localError userInfo:self.info];)
    
}

- (void)localErrorAndUnlockUI:(NSString *)text{
    if(self.delegate &&  [self.delegate respondsToSelector:@selector(unlockUI)]){
        [self.delegate unlockUI];
    }
    [self localError:text];
}

- (void)proccessLocalErrorByText:(NSString *)text{
    [self localErrorAndUnlockUI:text];
}

- (void)proccessNetwordError:(DError *)error{
    
    DelegateHasMethorAndDoOrLog(self.delegate, unlockUI, [self.delegate unlockUI];)
    
    [self removeLoadingView];
    if(error.isLocalError){
        if(error.localError.alertText.length == 0){
            return;
        }
        DelegateHasMethorAndDoOrLog(self.delegate, localError:userInfo:, [self.delegate localError:error.localError userInfo:self.info];)
        return;
    }
    
    [DErrorRespone proccessError:error delegate:self.delegate isAlertFor2Second:NO UserInfo:self.info];
}


@end
