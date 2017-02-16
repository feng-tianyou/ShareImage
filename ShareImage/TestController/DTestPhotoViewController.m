//
//  DTestPhotoViewController.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/6.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DTestPhotoViewController.h"
#import "DPhotoManager.h"


static NSString * const cellID = @"cell";

@interface DTestPhotoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, strong) DPhotoManager *photoManager;

@end

@implementation DTestPhotoViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //        _tableView.tableFooterView = [UIView new];
        //        _tableView.tableHeaderView = [UIView new];
        _tableView.backgroundColor = [UIColor redColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        
    }
    return _tableView;
}

- (NSArray *)photos{
    if (!_photos) {
        _photos = [NSArray array];
    }
    return _photos;
}

- (NSArray *)assets{
    if (!_assets) {
        _assets = [NSArray array];
    }
    return _assets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightAdd;
    
    self.photoManager = [DPhotoManager manager];
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
}


- (void)baseViewControllerDidClickNavigationLeftBtn:(UIButton *)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)baseViewControllerDidClickNavigationRightBtn:(UIButton *)rightBtn{
    
    self.photoManager.selectedAssets = self.assets;
    @weakify(self);
    [self.photoManager setDidFinishPickingPhotosWithInfosHandleBlock:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,NSArray<NSDictionary *> *infos) {
        @strongify(self)
        self.photos = photos;
        self.assets = assets;
        [self.tableView reloadData];
    }];
    //    [self.photoManager photoPickerWithMaxImagesCount:6 currentViewController:self];
    [self.photoManager photoPickerWithCurrentViewController:self];
    
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.imageView.image = self.photos[indexPath.row];
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.photoManager photoPreviewWithPhotoArray:self.assets currentIndex:indexPath.row currentViewController:self];
    
    //    NSArray *arr = @[@"http://7xv233.com1.z0.glb.clouddn.com/2016-06-08%2021_58_19.gif", @"http://7xv233.com1.z0.glb.clouddn.com/222.png", @"http://7xv233.com1.z0.glb.clouddn.com/D7AAE873-5F6F-477A-A6D4-1171FC91A735.png", @"http://7xv233.com1.z0.glb.clouddn.com/FullSizeRender.jpg"];
    
    
    //    [self.photoManager photoPreviewWithPhotos:self.photos currentIndex:indexPath.row currentViewController:self];
    //    [self.photoManager photoPreviewWithPhotoUrls:arr photos:nil currentIndex:0 currentViewController:self];
    
    
}

@end
