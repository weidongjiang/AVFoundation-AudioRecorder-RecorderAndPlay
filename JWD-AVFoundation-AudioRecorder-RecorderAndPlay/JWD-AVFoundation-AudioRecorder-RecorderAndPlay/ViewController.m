//
//  ViewController.m
//  JWD-AVFoundation-AudioRecorder-RecorderAndPlay
//
//  Created by 蒋伟东 on 16/10/18.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


#define KScreenWidth       ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight      ([UIScreen mainScreen].bounds.size.height)

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *recorderBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, KScreenHeight-50, (KScreenWidth-30)*0.5, 40)];
    [recorderBtn setTitle:@"录制" forState:UIControlStateNormal];
    recorderBtn.backgroundColor = [UIColor greenColor];
    recorderBtn.layer.cornerRadius = 10;
    recorderBtn.layer.masksToBounds = YES;
    [recorderBtn addTarget:self action:@selector(recorderBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recorderBtn];

    UIButton *stopBtn = [[UIButton alloc] initWithFrame:CGRectMake((KScreenWidth-30)*0.5+20, KScreenHeight-50, (KScreenWidth-30)*0.5, 40)];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    stopBtn.backgroundColor = [UIColor redColor];
    stopBtn.layer.cornerRadius = 10;
    stopBtn.layer.masksToBounds = YES;
     [stopBtn addTarget:self action:@selector(stopBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
}
- (void)recorderBtnDidClick:(UIButton *)recorder {
    NSLog(@"录制");
}

- (void)stopBtnDidClick:(UIButton *)recorder {
    NSLog(@"暂停");

}

@end
























