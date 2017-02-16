//
//  DScanQRCodeViewController.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DScanQRCodeViewController.h"
#import "ZBarSDK.h"
#import "DHttpTool.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DScanQRCodeViewController ()<ZBarReaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZBarReaderDelegate,AVCaptureMetadataOutputObjectsDelegate>
{
    ZBarReaderView *_readerView;
    UIView *_viewBG1;
    UIView *_viewBG2;
    UIView *_viewBG3;
    UIView *_viewBG4;
    
    UIImageView *_imgLeftUp;
    UIImageView *_imgRightUp;
    UIImageView *_imgLeftDown;
    UIImageView *_imgRightDown;
    
    UIImageView *_imgLine;
    
    UILabel *_tipLabel;
}

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@end

@implementation DScanQRCodeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_session && !_session.isRunning){
        [_session startRunning];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫一扫";
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightPoint;
    
    // 初始化子控家
    [self setupSubViews];
    
    // 初始化相机
    [self setupCamera];
    
}

#pragma mark - 导航栏方法
- (void)baseViewControllerDidClickNavigationLeftBtn:(UIButton *)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)baseViewControllerDidClickNavigationRightBtn:(UIButton *)rightBtn{
    @weakify(self)
    UIAlertController *controller = [[UIAlertController alloc] init];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        @strongify(self);
////        [self openCamera];
//    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册中选择二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self openPhoto];
    }];
//    [controller addAction:camera];
    [controller addAction:album];
    [controller addAction:cancel];
    
    [self presentViewController:controller animated:YES completion:nil];
}


#pragma mark - 私有方法
- (UIView *)setupView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = SCAN_QRCODE_BGCOLOR;
    return view;
}

- (UIImageView *)setupImageViewWithImageName:(NSString *)imageName{
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView setImage:[UIImage getImageWithName:imageName]];
    return imgView;
}

- (void)setupSubViews{
    _viewBG1 = [self setupView];
    _viewBG2 = [self setupView];
    _viewBG3 = [self setupView];
    _viewBG4 = [self setupView];
    
    _imgLeftUp = [self setupImageViewWithImageName:SCAN_QRCODE_IMG_LEFT_UP];
    _imgRightUp = [self setupImageViewWithImageName:SCAN_QRCODE_IMG_RIGHT_UP];
    _imgLeftDown = [self setupImageViewWithImageName:SCAN_QRCODE_IMG_LEFT_DOWN];
    _imgRightDown = [self setupImageViewWithImageName:SCAN_QRCODE_IMG_RIGHT_DOWN];
    _imgLine = [self setupImageViewWithImageName:SCAN_QRCODE_IMG_LINE];
    
    _tipLabel = ({
        UILabel *tipLabel = [[UILabel alloc] init];
        [tipLabel setNumberOfLines:0];
        [tipLabel setText:@"将二维码图案放在取景框内，即可自动扫描"];
        [tipLabel setTextColor:[UIColor whiteColor]];
        [tipLabel setBackgroundColor:[UIColor clearColor]];
        [tipLabel setTextAlignment:NSTextAlignmentCenter];
        [tipLabel setFont:DSystemFontAlert];
        tipLabel;
    });
    
    [self.view addSubview:_viewBG1];
    [self.view addSubview:_viewBG2];
    [self.view addSubview:_viewBG3];
    [self.view addSubview:_viewBG4];
    [self.view addSubview:_imgLeftDown];
    [self.view addSubview:_imgLeftUp];
    [self.view addSubview:_imgRightDown];
    [self.view addSubview:_imgRightUp];
    [self.view addSubview:_imgLine];
    [self.view addSubview:_tipLabel];
    
    
    // layout
    CGFloat scanWidth = self.view.width - 80;
    _viewBG1.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .widthIs(40);
    
    _viewBG2.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(_viewBG1, 0)
    .rightSpaceToView(self.view, 40)
    .heightIs(40);
    
    _viewBG3.sd_layout
    .topEqualToView(_viewBG2)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .widthIs(40);
    
    CGFloat bg4Height = self.view.height - 40 - scanWidth - 64;
    _viewBG4.sd_layout
    .rightSpaceToView(_viewBG3, 0)
    .leftSpaceToView(_viewBG1, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(bg4Height);
    
    _imgLeftUp.sd_layout
    .topSpaceToView(_viewBG2,-3)
    .leftSpaceToView(_viewBG1, -3)
    .heightIs(37)
    .widthIs(37);
    
    _imgLeftDown.sd_layout
    .topSpaceToView(_viewBG2, scanWidth-34)
    .leftSpaceToView(_viewBG1, -3)
    .heightIs(37)
    .widthIs(37);
    
    _imgRightUp.sd_layout
    .topSpaceToView(_viewBG2, -3)
    .rightSpaceToView(_viewBG3, -3)
    .heightIs(37)
    .widthIs(37);
    
    _imgRightDown.sd_layout
    .topSpaceToView(_viewBG2, scanWidth-34)
    .rightSpaceToView(_viewBG3, -3)
    .heightIs(37)
    .widthIs(37);
    
    [_imgLine setFrame:CGRectMake(40, 40, self.view.width - 80, 2)];
    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        [_imgLine setFrame:CGRectMake(40, (scanWidth + 40), self.view.width - 80, 2)];
    } completion:^(BOOL finished) {
        
    }];
    
    _tipLabel.sd_layout
    .topSpaceToView(_imgRightDown, 20)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .autoHeightRatio(0);
}

- (void)setupCamera{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    if (_device == nil && _input == nil) {
        [self localError:@"设备不支持相机" isAlertFor2Second:YES];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //可扫描范围（y,x,height,width）
    [_output setRectOfInterest:CGRectMake(40/self.view.height, 40/self.view.width, (self.view.width - 80)/self.view.height, (self.view.width - 80)/self.view.width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}


/**
 处理扫描得到的内容

 @param strContent 二维码内容
 */
- (void)proccessQRCodeStrContent:(NSString *)strContent{
    if (strContent.length == 0) return;
    // 进行URL处理
    NSArray *urlArr = [DHttpTool getUrlWithStrContent:strContent];
    @weakify(self)
    if (urlArr.count > 0) {
        NSString *strMessage = [NSString stringWithFormat:@"扫描到以下链接:%@,是否需要继续访问？",[urlArr objectAtIndex:0]];
        DAlertView *alert = [[DAlertView alloc] initWithTitle:@"" andMessage:strMessage];
        
        [alert addButtonWithTitle:@"取消" type:CustomAlertViewButtonTypeCancel handler:^(DAlertView *alertView) {
            [_session startRunning];
        }];
        
        [alert addButtonWithTitle:@"确定" type:CustomAlertViewButtonTypeCancel handler:^(DAlertView *alertView) {
            
        }];
        [alert show];
    } else {
        NSString *strMessage = [NSString stringWithFormat:@"无法识别此二维码:%@",strContent];
        DAlertView *alert = [[DAlertView alloc] initWithTitle:@"" andMessage:strMessage];
        [alert addButtonWithTitle:@"确定" type:CustomAlertViewButtonTypeCancel handler:^(DAlertView *alertView) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert show];
    }
}

- (void)openPhoto{
    ALAuthorizationStatus state = [ALAssetsLibrary authorizationStatus];
    if(state == AVAuthorizationStatusRestricted || state == AVAuthorizationStatusDenied)
    {
        DAlertView *alertView=[[DAlertView alloc] initWithTitle:nil andMessage:@"请在iPhone的“设置-隐私-相册”选项中允许访问您的手机相册"];
        [alertView addButtonWithTitle:@"确定" type:CustomAlertViewButtonTypeCancel handler:nil];
        [alertView show];
        
        return;
    }
    
    ZBarReaderController *readerController = [[ZBarReaderController alloc] init];
    [readerController setDelegate:self];
    readerController.showsHelpOnFail = NO;
    [readerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:readerController animated:YES completion:NULL];
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        DLog(@"%@",metadataObject.stringValue);
        [self proccessQRCodeStrContent:metadataObject.stringValue];
    }
    
    [_session stopRunning];
}

#pragma mark - ZBarReaderViewDelegate
- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image{
    // 得到扫描的条码内容
    const zbar_symbol_t *symbol = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    NSString *symbolStr = [NSString stringWithUTF8String: zbar_symbol_get_data(symbol)];
    if (zbar_symbol_get_type(symbol) == ZBAR_QRCODE) { // 是否QR二维码
        DLog(@"%@",symbolStr);
        [self proccessQRCodeStrContent:symbolStr];
    }
}

#pragma  mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePickerController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol;
    for(symbol in results)
        break;
    NSString *strContent = symbol.data;
    [self proccessQRCodeStrContent:strContent];
    
}


@end
