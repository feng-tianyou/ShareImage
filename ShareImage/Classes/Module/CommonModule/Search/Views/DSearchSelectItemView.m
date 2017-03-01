//
//  DSearchSelectItemView.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchSelectItemView.h"

@implementation DSearchSelectItemView


#pragma mark - getter & setter
- (UIButton *)photoBtn{
    if (!_photoBtn) {
        _photoBtn = [[UIButton alloc] init];
        
    }
    return _photoBtn;
}

@end
