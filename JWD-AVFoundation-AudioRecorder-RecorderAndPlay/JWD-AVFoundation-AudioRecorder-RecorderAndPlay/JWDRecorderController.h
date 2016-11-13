//
//  JWDRecorderController.h
//  JWD-AVFoundation-AudioRecorder-RecorderAndPlay
//
//  Created by 蒋伟东 on 2016/10/18.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JWDRecordingStopCompletionHandler) (BOOL);
typedef void(^JWDRecordingSaveCompletionHandler)(BOOL,id);

@interface JWDRecorderController : NSObject

@property(nonatomic, strong)JWDRecordingStopCompletionHandler stopHandler;//!< <#value#>

// 录制
- (BOOL)record;
// 暂停
- (void)pause;
// 停止
- (void)stop;

// 停止
- (void)stopWithCompletionHandler:(JWDRecordingStopCompletionHandler)stopHandler;


// 保存
- (void)saveRecordingWithName:(NSString *)name
            completionHandler:(JWDRecordingSaveCompletionHandler)saveHandler;


@end
