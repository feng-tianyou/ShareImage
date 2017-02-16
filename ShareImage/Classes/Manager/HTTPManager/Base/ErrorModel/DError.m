//
//  DError.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DError.h"

static NSDictionary *errorCodes;

@implementation DError

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self)
    {
        self.errorTitle         = [decoder decodeObjectForKey:@"error"];
        self.errorCode          = [decoder decodeObjectForKey:@"error_code"];
        self.errorDescription   = [decoder decodeObjectForKey:@"error_description"];
        self.errorUri           = [decoder decodeObjectForKey:@"error_uri"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.errorTitle forKey:@"error"];
    [encoder encodeObject:self.errorCode forKey:@"error_code"];
    [encoder encodeObject:self.errorDescription forKey:@"error_description"];
    [encoder encodeObject:self.errorUri forKey:@"error_uri"];
}

-(id)copyWithZone:(NSZone *)zone
{
    id copyData = [[[self class] allocWithZone:zone] init];
    [copyData setErrorCode:self.errorCode];
    [copyData setErrorTitle:self.errorTitle];
    [copyData setErrorDescription:self.errorDescription];
    [copyData setErrorUri:self.errorUri];
    return copyData;
}


#pragma mark super class implementations

- (NSInteger)code
{
    if([self.errorCode intValue] == 0)
    {
        return (int)[super code];
    }
    else
    {
        return [self.errorCode intValue];
    }
}

-(NSString *)domain
{
    // we are assuming that any request within 1000 to 5000 is thrown by our server
    if([self.errorCode intValue] > 1000 && [self.errorCode intValue] < 5000)
    {
        return kBugErrorDomain;
    }
    else
    {
        return kRequestErrorDomain;
    }
}


#pragma mark Our implementations

+ (id)getErrorByAlertText:(NSString *)alertText{
    DError *error = [[DError alloc] init];
    error.isLocalError = YES;
    error.localError = [[DLocalError alloc] initWithAlertFor2Second:NO
                                                         titleText:@""
                                                         alertText:alertText];
    return error;
}

+ (id)getErrorFor2SecondByAlertText:(NSString *)alertText{
    DError *error = [[DError alloc] init];
    error.isLocalError = YES;
    error.localError = [[DLocalError alloc] initWithAlertFor2Second:YES
                                                         titleText:@""
                                                         alertText:alertText];
    return error;
}


-(id) initWithDictionary:(NSDictionary*) jsonObject
{
    self = [super init];
    if(self)
    {
        if([jsonObject objectForKey:@"state_code"] && [jsonObject objectForKey:@"state_code"] != kNull){
            self.errorCode = [NSString stringWithFormat:@"%@",[jsonObject objectForKey:@"state_code"]];
        }
        if([jsonObject objectForKey:@"message"] && [jsonObject objectForKey:@"message"] != kNull){
            self.errorDescription = [jsonObject objectForKey:@"message"];
        }
    }
    return self;
}

-(id) initWithCode:(NSInteger)code description:(NSString*)description{
    self = [super init];
    if(self)
    {
        self.errorCode = [NSString stringWithFormat:@"%d",(int)code];
        self.errorDescription = description;
    }
    return self;
}

-(id)initWithErrorCode:(NSString *)errorCode{
    self = [super init];
    if(self)
    {
        self.errorCode = errorCode;
    }
    return self;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"/n----TGError---/nErrorCode:%@/nErrorDes:%@/n----TGError---",_errorCode,_errorDescription];
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"/n----TGError---/nErrorCode:%@/nErrorDes:%@/n----TGError---",_errorCode,_errorDescription];
}


@end
