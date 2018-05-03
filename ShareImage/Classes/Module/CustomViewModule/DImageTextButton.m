//
//  DImageTextButton.m
//  DFrame
//
//  Created by DaiSuke on 16/9/13.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DImageTextButton.h"

@implementation DImageTextButton
- (id)init{
    if(self = [super init]){
        [self proccessView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsLayout];
}

- (void)proccessView{
    
    _imgView = ({
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView;
    });
    [self addSubview:_imgView];
    
    _lblTitle = ({
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setFont:[UIFont systemFontOfSize:16.0]];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setNumberOfLines:0];
        [lbl setBackgroundColor:[UIColor clearColor]];
        lbl;
    });
    [self addSubview:_lblTitle];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if(_imgFrame.size.width > 0){
        [_imgView setFrame:_imgFrame];
    }
    else{
        CGSize sizeImg = CGSizeMake(20, 20);
        if(_imgSize.width > 0){
            sizeImg = _imgSize;
        }
        _imgView.frame = CGRectMake(10, (self.frame.size.height - sizeImg.height)/2.0, sizeImg.width, sizeImg.height);
    }
    
    CGFloat width = CGRectGetMaxX(_imgView.frame) + 10;
    if(_nullImg){
        width = 10;
    }
    
    _lblTitle.frame = CGRectMake(width, 0, (self.frame.size.width - width - 10), self.frame.size.height);
    if(_imgIsAtRight){
        width = CGRectGetMidX(_imgView.frame) - 5;
        _lblTitle.frame = CGRectMake(10, 10, width - 10, self.frame.size.height);
    }
    
}

- (void)reloadLayoutSubviews{
    [self setNeedsLayout];
}

@end
