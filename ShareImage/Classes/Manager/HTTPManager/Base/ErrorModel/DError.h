//
//  DError.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRequestErrorDomain @"HTTP_ERROR"
#define kBugErrorDomain @"ERRORCODE_OUT_OF_RANGE"

@class DLocalError;
@interface DError : NSError

@property (nonatomic, copy) NSString *errorTitle;
@property (nonatomic, copy) NSString *errorCode;
@property (nonatomic, copy) NSString *errorDescription;
@property (nonatomic, copy) NSString *errorUri;
@property (nonatomic, assign) BOOL isLocalError;
@property (nonatomic, strong) DLocalError *localError;

- (id) initWithErrorCode:(NSString *)errorCode;
- (id) initWithDictionary:(NSDictionary*) jsonObject;
- (id) initWithCode:(NSInteger)code description:(NSString*)description;

+ (id)getErrorByAlertText:(NSString *)alertText;

+ (id)getErrorFor2SecondByAlertText:(NSString *)alertText;

@end
