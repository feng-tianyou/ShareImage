//
//  DLanguageViewController.m
//  ShareImage
//
//  Created by FTY on 2017/3/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DLanguageViewController.h"
#import "DLanguageManager.h"
#import "DUITableView.h"

@interface DLanguageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DUITableView *tableView;
@property (nonatomic, strong) NSArray *languages;
//@property (nonatomic, strong) NSArray *languageArr;

@end

@implementation DLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kLocalizedLanguage(@"language");
    self.navRighItemType = DNavigationItemTypeRightSave;
    self.navLeftItemType = DNavigationItemTypeRightCancel;
    
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (isLeft) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - private

/**
 根据语言获取语言的国家语言

 @param lang 语言
 @return 国家语言
 */
- (NSString *)getCountryWithLanguage:(NSString *)lang{
    NSString *language = [kLanguageManager languageFormat:lang];
    NSString *countryLanguage = [[[NSLocale alloc] initWithLocaleIdentifier:language] displayNameForKey:NSLocaleIdentifier value:language];
    return countryLanguage;
}

/**
 根据语言获取语言的名称

 @param lang 语言
 @return 名称
 */
- (NSString *)getCurrentLanguageName:(NSString *)lang{
    NSString *language = [kLanguageManager languageFormat:lang];
    // 当前语言
    NSString *currentLanguage = kLanguageManager.currentLanguage;
    // 当前语言下的对应国家语言翻译
    NSString *currentLanguageName = [[[NSLocale alloc] initWithLocaleIdentifier:currentLanguage] displayNameForKey:NSLocaleIdentifier value:language];
    return currentLanguageName;
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    // 获取文件语言类型
    NSString *language = [kLanguageManager languageFormat:self.languages[indexPath.row]];
    // 根据语言获取语言的国家语言
    NSString *countryLanguage = [self getCountryWithLanguage:language];
    // 根据语言获取语言的名称
    NSString *currentLanguageName = [self getCurrentLanguageName:self.languages[indexPath.row]];
    
    cell.textLabel.text = countryLanguage;
    cell.detailTextLabel.text = currentLanguageName;
    
    // 当前语言
    NSString *currentLanguage = kLanguageManager.currentLanguage;
    if ([currentLanguage rangeOfString:language].location != NSNotFound) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *language = self.languages[indexPath.row];
    [kLanguageManager setUserlanguage:language];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - getter & setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[DUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

//目前支持的语言
- (NSArray *)languages{
    return @[@"zh-Hans-CN", //中文简体
             @"zh-Hant-CN", //中文繁体
             @"en-CN", //英语
             @"ko-CN", //韩语
             @"ja-CN", //日语
             @"fr-CN", //法语
             @"it-CN"]; //意大利语
}

//- (NSMutableArray *)languages{
//    if (!_languages) {
//        _languages = [[NSMutableArray alloc] init];
//        [self.languageArr enumerateObjectsUsingBlock:^(NSString *lang, NSUInteger idx, BOOL * _Nonnull stop) {
//            //对应国家的语言
////            NSString *countryLanguage = [self getCountryWithLanguage:lang];
////            //当前语言下的对应国家语言翻译
////            NSString *currentLanguageName = [self getCurrentLanguageName:lang] ;
//            
////            if([countryLanguage rangeOfString:_searchText options:NSCaseInsensitiveSearch].location != NSNotFound || [currentLanguageName rangeOfString:_searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
////                [_dataAry addObject:lang];
////            }
//            [_languages addObject:lang];
//        }];
//    }
//    return _languages;
//}


@end
