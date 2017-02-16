//
//  DCustomAlertView.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DCustomAlertView.h"

@interface DCustomAlertView ()
{
    UIControl *_controlAlert;
    UIImageView *_imgView;
    UILabel *_lblTitle;
    UILabel *_lblContent;
    UILabel *_line;
    UIButton *_btnAction;
}

@end

@implementation DCustomAlertView

- (id)init{
    if(self = [super init]){
        [self proccessData];
        [self proccessView];
    }
    return self;
}

- (void)proccessData{
    
}

- (void)proccessView{
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    _controlAlert = ({
        UIControl *control = [[UIControl alloc] init];
        [control setBackgroundColor:[UIColor whiteColor]];
        [control.layer setCornerRadius:6.0];
        [control.layer setMasksToBounds:YES];
        control;
    });
    [self addSubview:_controlAlert];
    
    
    _imgView = ({
        UIImageView *img = [[UIImageView alloc] init];
        img;
    });
    [_controlAlert addSubview:_imgView];
    
    _lblTitle = ({
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setTextColor:DSystemColorYellowTink];
        [lbl setFont:DSystemFontTitle];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setBackgroundColor:[UIColor clearColor]];
        lbl;
    });
    [_controlAlert addSubview:_lblTitle];
    
    _lblContent = ({
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:DSystemFontText];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setBackgroundColor:[UIColor clearColor]];
        lbl;
    });
    [_controlAlert addSubview:_lblContent];
    
    _line = ({
        UILabel *line = [[UILabel alloc] init];
        line;
    });
    [_controlAlert addSubview:_line];
    
    _btnAction = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:DSystemColorBlue forState:UIControlStateNormal];
        [btn.titleLabel setFont:DSystemFontTitle];
        [btn addTarget:self action:@selector(pressToAction) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [_controlAlert addSubview:_btnAction];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat controlWidth = self.width - 40;
    
    CGFloat currentHeight = 20;
    
    CGSize imgSize = _imgView.image.size;
    [_imgView setFrame:(controlWidth - imgSize.width)/2.0 y:currentHeight w:imgSize.width h:imgSize.height];
    currentHeight += imgSize.height + 5;
    
    [_lblTitle setFrame:10 y:currentHeight w:controlWidth - 20 h:20];
    currentHeight += 30;
    
    [_lblContent setFrame:10 y:currentHeight w:controlWidth - 20 h:20];
    currentHeight += 40;
    
    [_line setFrame:20 y:currentHeight w:(controlWidth - 40) h:1];
    currentHeight += 1;
    
    [_btnAction setFrame:10 y:currentHeight w:controlWidth - 20 h:50];
    currentHeight += 50;
    
    [_controlAlert setFrame:20 y:(self.height - currentHeight)/2.0 w:controlWidth h:currentHeight];
    
}

- (void)setImage:(UIImage *)img title:(NSString *)title content:(NSString *)content btnTitle:(NSString *)btnTitle{
    
    [_imgView setImage:img];
    [_lblTitle setText:title];
    [_lblContent setText:content];
    [_btnAction setTitle:btnTitle forState:UIControlStateNormal];
    
    [self setNeedsLayout];
}

- (void)pressToAction{
    DelegateHasMethorAndDo(_delegate, customAlertViewDidPressToAction, [_delegate customAlertViewDidPressToAction];);
}



@end
