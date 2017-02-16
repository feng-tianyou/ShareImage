//
//  DHeaderView.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/8.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHeaderView.h"
#import "DCustomButton.h"

@interface DHeaderView ()

@end

@implementation DHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *datas = @[@{@"icon":@"friend_list_group", @"title":@"转发"}, @{@"icon":@"message_cooperation_delete", @"title":@"编辑"}, @{@"icon":@"message_project_alert", @"title":@"提醒"}, @{@"icon":@"message_project_resource", @"title":@"关注"}];
        
        [datas enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DCustomButton *button = [[DCustomButton alloc] init];
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"icon"]] forState:UIControlStateNormal];
            [button setTitle:[dic objectForKey:@"title"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = idx;
//            button.backgroundColor = [UIColor redColor];
            [self addSubview:button];
        }];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        btnW = (self.frame.size.width - 20) / self.subviews.count;
    }
    CGFloat btnY = (self.frame.size.height - 80) / 2;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        button.frame = CGRectMake(idx * btnW, btnY, btnW, 80);
    }];
    
}

- (void)clickBtn:(DCustomButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:didSelectWithIndex:)]) {
        [self.delegate headerView:self didSelectWithIndex:btn.tag];
    }
}


@end
