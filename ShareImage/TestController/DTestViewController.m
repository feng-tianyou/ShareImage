//
//  DTestViewController.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/11.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DTestViewController.h"
#import "DTestTableViewCell.h"


static NSString * const cellID = @"cell";

@interface DTestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *photos;

@end

@implementation DTestViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[DTestTableViewCell class] forCellReuseIdentifier:cellID];
        
    }
    return _tableView;
}

//- (NSArray *)photos{
//    if (!_photos) {
//        NSMutableArray *arr = [NSMutableArray array];
//        for (int i =0; i<20; i++) {
//            testModel *model = [[testModel alloc] init];
//            model.name = [NSString stringWithFormat:@"名字---%@", @(i)];
//            model.project = @"项目";
//            model.date = [NSString stringWithFormat:@"2013/1/%@", @(i)];
//            if ((i % 2) == 0) {
//                model.content = @"2222222死都不放假按时到北京奥克斯阿斯兰的空间爱上大家爱看啥都能奥斯卡级等哈看十多年爱上的框架爱就是打哈吉林省爱上当看见俺看了啥电脑啊实打实的金卡是";
//            } else {
//                model.content = @"死都不放假按时到北京奥克斯阿斯兰的空间爱上大家爱看啥都能奥斯卡级等哈看萨达哈是老款的奥斯卡的骄傲是离开地面奥斯卡大家爱思考；来得及啊实打实的十多年爱上的框架爱就是打哈吉林省爱上当看见俺看了啥电脑啊实打实的金卡是";
//            }
//            model.icon = @"http://daisuke.cn/uploads/avatar.png";
//            [arr addObject:model];
//        }
//        _photos = [arr copy];
//    }
//    return _photos;
//}


- (void)setupDatas{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i =0; i<20; i++) {
        testModel *model = [[testModel alloc] init];
        model.name = [NSString stringWithFormat:@"名字---%@", @(i)];
        model.project = @"项目";
        model.date = [NSString stringWithFormat:@"2013/1/%@", @(i)];
        if ((i % 2) == 0) {
            model.content = @"2222222死都不放假按时到北京奥克斯阿斯兰的空间爱上大家爱看啥都能奥斯卡级等哈看十多年爱上的框架爱就是打哈吉林省爱上当看见俺看了啥电脑啊实打实的金卡是";
        } else {
            model.content = @"死都不放假按时到北京奥克斯阿斯兰的空间爱上大家爱看啥都能奥斯卡级等哈看萨达哈是老款的奥斯卡的骄傲是离开地面奥斯卡大家爱思考；来得及啊实打实的十多年爱上的框架爱就是打哈吉林省爱上当看见俺看了啥电脑啊实打实的金卡是";
        }
        model.icon = @"http://daisuke.cn/uploads/avatar.png";
        [arr addObject:model];
    }
    self.photos = [arr copy];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"测试";
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightNext;
    
    [self setupDatas];
    
    [self.tableView setFrame:0 y:0 w:self.view.width h:self.view.height-64];
    [self.view addSubview:self.tableView];
}

//- (void)baseViewControllerDidClickNavigationLeftBtn:(UIButton *)leftBtn{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)baseViewControllerDidClickNavigationRightBtn:(UIButton *)rightBtn{
//
//}

- (void)baseViewControllerDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (!isLeft) {
        
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.photos[indexPath.row];
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DTestTableViewCell class] contentViewWidth:self.view.width];
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.model = self.photos[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

@end
