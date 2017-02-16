//
//  DLottieViewController.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/10.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DLottieViewController.h"
#import "Lottie.h"

@interface DLottieViewController ()

@property (nonatomic, strong) LOTAnimationView *laAnimation;
@end

@implementation DLottieViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect b = self.view.bounds;
    self.laAnimation.frame = CGRectMake(0, 64, b.size.width, 300);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _loadAnimationNamed:@"MotionCorpse-Jrcanest"];
    
    UIButton *startbutton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 100, 40)];
    [startbutton setBackgroundColor:[UIColor redColor]];
    [startbutton setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:startbutton];
    [startbutton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *closebutton = [[UIButton alloc] initWithFrame:CGRectMake(160, 310, 100, 40)];
    [closebutton setBackgroundColor:[UIColor redColor]];
    [closebutton setTitle:@"close" forState:UIControlStateNormal];
    [self.view addSubview:closebutton];
    [closebutton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];

}



- (void)_loadAnimationNamed:(NSString *)named {
//    [self.laAnimation removeFromSuperview];
//    self.laAnimation = nil;
    
    self.laAnimation = [LOTAnimationView animationNamed:named];
    self.laAnimation.contentMode = UIViewContentModeScaleAspectFit;
    self.laAnimation.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.laAnimation];
    [self.view setNeedsLayout];
}


- (void)play{
    if (self.laAnimation.isAnimationPlaying) {
        [self.laAnimation pause];
    } else {
        [self.laAnimation playWithCompletion:^(BOOL animationFinished) {
            NSLog(@"播完了");
        }];
    }
}


- (void)close {
    [self lottieDismissViewControllerAnimated:YES completion:nil];
}



@end
