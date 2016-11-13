//
//  ViewController.m
//  JWD-AVFoundation-AudioRecorder-RecorderAndPlay
//
//  Created by 蒋伟东 on 16/10/18.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "ViewController.h"
#import "JWDRecorderController.h"
#import "JWDRecorderCell.h"
#import "JWDRecorderModel.h"

#define KScreenWidth       ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight      ([UIScreen mainScreen].bounds.size.height)

#define KcellID    @"cellid"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)JWDRecorderController *recorderController;//!< <#value#>
@property(nonatomic, strong)NSMutableArray        *dataArray;//!< 数据源
@property(nonatomic, strong)UITableView           *tableview;//!< <#value#>
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [self setUpUI];
    
    // 创建录制
    self.recorderController = [[JWDRecorderController alloc] init];
    
    
}

- (void)setUpUI{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-80) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[JWDRecorderCell class] forCellReuseIdentifier:KcellID];
    
    
    
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
    [self.recorderController record];

}

- (void)stopBtnDidClick:(UIButton *)recorder {
    NSLog(@"停止");
    [self.recorderController stop];
    [self showSaveDialog];
}

- (void)showSaveDialog {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Save Recording"
                                          message:@"Please provide a name"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"My Recording", @"Login");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *filename = [alertController.textFields.firstObject text];
        [self.recorderController saveRecordingWithName:filename completionHandler:^(BOOL success, id object) {
            if (success) {
                [self.dataArray addObject:object];
//                [self saveMemos];
                [self.tableview reloadData];
            } else {
                NSLog(@"Error saving file: %@", [object localizedDescription]);
            }
        }];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITableView Datasource and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JWDRecorderCell *cell = [tableView dequeueReusableCellWithIdentifier:KcellID];
    JWDRecorderModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JWDRecorderModel *model = self.dataArray[indexPath.row];
//    [self.controller playbackMemo:memo];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        JWDRecorderModel *model = self.dataArray[indexPath.row];
        
        [model deleteMemo];// 删除数据库
        
        [self.dataArray removeObjectAtIndex:indexPath.row]; // 删除数组
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



@end
























