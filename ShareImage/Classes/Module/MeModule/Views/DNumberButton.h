//
//  DNumberButton.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/26.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNumberButton : UIControl

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *describleLabel;

- (instancetype)initWithDescrible:(NSString *)describle;

@end
