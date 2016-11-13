//
//  JWDRecorderController.m
//  JWD-AVFoundation-AudioRecorder-RecorderAndPlay
//
//  Created by 蒋伟东 on 2016/10/18.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "JWDRecorderController.h"
#import <AVFoundation/AVFoundation.h>
#import "JWDRecorderModel.h"
#import "JWDMeterArray.h"

@interface JWDRecorderController ()<AVAudioRecorderDelegate>

@property(nonatomic, strong)AVAudioRecorder *recorder;//!< <#value#>
@property(nonatomic, strong)AVAudioPlayer *player;//!< <#value#>
@property(nonatomic, strong)JWDMeterArray *meterArray;//!< <#value#>

@end

@implementation JWDRecorderController

- (instancetype)init {

    self = [super init];
    if (self){
    
        // 存储临时缓存
        NSString *tempDir = NSTemporaryDirectory();
        NSString *filePath = [tempDir stringByAppendingPathComponent:@"temp.caf"];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        
        // 设置录制音频参数
        NSDictionary *settings = @{
                                   AVFormatIDKey :@(kAudioFormatAppleIMA4),//音频格式
                                   AVSampleRateKey:@44100.0f,// 采样率
                                   AVEncoderBitDepthHintKey:@16,// 位深
                                   AVEncoderAudioQualityKey:@(AVAudioQualityMedium),// 录音质量
                                   
                                   };
        NSError *error;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:fileUrl settings:settings error:&error];
        
        if(self.recorder){
            
            self.recorder.delegate = self;
            self.recorder.meteringEnabled = YES;
            [self.recorder prepareToRecord];
        }else {
            NSLog(@"[AVAudioRecorder alloc] error:%@",[error localizedDescription]);
        }
        
    }
    return self;
}


- (BOOL)record {

    return [self.recorder record];
}

- (void)pause {
    [self.recorder pause];
}

- (void)stop{

    [self.recorder stop];
}

// 停止
- (void)stopWithCompletionHandler:(JWDRecordingStopCompletionHandler)stopHandler {
    self.stopHandler = stopHandler;
    [self stop];
}

// 保存
- (void)saveRecordingWithName:(NSString *)name
            completionHandler:(JWDRecordingSaveCompletionHandler)saveHandler {
    NSString *topath = [self docunmentsDirectoryWithName:name];
    NSURL *toUrl = [NSURL fileURLWithPath:topath];
    NSURL *atUrl = self.recorder.url;
    
    NSError *error;
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtURL:atUrl toURL:toUrl error:&error];
    if (isSuccess) {
        saveHandler(YES,[JWDRecorderModel memoWithTitle:name url:toUrl]);
    } else {
        saveHandler(NO,error);
    }
    
}

- (NSString *)docunmentsDirectoryWithName:(NSString *)name {
    
    NSTimeInterval timeSatmp = [NSDate timeIntervalSinceReferenceDate];
    NSString *filename = [NSString stringWithFormat:@"%@-%f.caf",name,timeSatmp];
    NSString *docsdir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return  [docsdir stringByAppendingPathComponent:filename];
}

- (void)playRecodeWithMoedl:(JWDRecorderModel *)model {

    [self.player stop];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:model.url error:nil];
    if (self.player) {
        [self.player play];
    }
}


- (double)getLevelRecoder {
    [self.recorder updateMeters];

    float peak = [self.recorder peakPowerForChannel:0];
    float average = [self.recorder averagePowerForChannel:0];
    NSLog(@"最高 分贝 %f, 平均 %f",peak,average);
    
    double peaklowPassResults = pow(10, (0.05 * peak));
    double averagelowPassResults = pow(10, (0.05 * average));
    NSLog(@"peaklowPassResults%lf,averagelowPassResults%lf",peaklowPassResults,averagelowPassResults);
    
    return peaklowPassResults;
}

// 录制结束
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
     NSLog(@"audioRecorderDidFinishRecording");
    
    
}



@end












