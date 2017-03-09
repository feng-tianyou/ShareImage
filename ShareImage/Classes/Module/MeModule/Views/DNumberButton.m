//
//  DNumberButton.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/26.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DNumberButton.h"

@interface DNumberButton ()
@property (nonatomic, copy) NSString *describle;
@end


@implementation DNumberButton

- (instancetype)initWithDescrible:(NSString *)describle{
    self = [super init];
    if (self) {
        self.describle = describle;
        [self addSubview:self.numberLabel];
        [self addSubview:self.describleLabel];
        
        self.numberLabel.sd_layout
        .topEqualToView(self)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(25);
        
        self.describleLabel.sd_layout
        .topSpaceToView(self.numberLabel, 5)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(20);
    }
    return self;
}



#pragma mark - setter & getter
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:25.0];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

- (UILabel *)describleLabel{
    if (!_describleLabel) {
        _describleLabel = [[UILabel alloc] init];
        _describleLabel.textColor = DSystemColorGray;
        _describleLabel.font = [UIFont systemFontOfSize:14.0];
        _describleLabel.textAlignment = NSTextAlignmentCenter;
        _describleLabel.text = self.describle;
    }
    return _describleLabel;
}

@end
