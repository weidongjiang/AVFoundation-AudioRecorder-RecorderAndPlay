//
//  JWDRecorderModel.h
//  JWD-AVFoundation-AudioRecorder-RecorderAndPlay
//
//  Created by 蒋伟东 on 2016/11/13.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWDRecorderModel : NSObject


@property (copy, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSURL *url;
@property (copy, nonatomic, readonly) NSString *dateString;
@property (copy, nonatomic, readonly) NSString *timeString;

+ (instancetype)memoWithTitle:(NSString *)title url:(NSURL *)url;

- (BOOL)deleteMemo;

@end
