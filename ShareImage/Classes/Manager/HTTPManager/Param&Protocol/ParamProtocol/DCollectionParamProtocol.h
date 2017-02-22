//
//  DCollectionParamProtocol.h
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DCollectionParamProtocol <NSObject>
/// 分类id
@property (nonatomic, assign) long long collection_id;

// 页数，默认1
@property (nonatomic, assign) NSInteger page;
// 每页多少条，默认10
@property (nonatomic, assign) NSInteger per_page;


#pragma mark - collections
- (NSDictionary *)getParamDicForGetCollections;

@end
