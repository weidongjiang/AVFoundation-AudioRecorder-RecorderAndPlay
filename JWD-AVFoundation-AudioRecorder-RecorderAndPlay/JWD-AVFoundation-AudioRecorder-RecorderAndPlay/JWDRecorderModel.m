//
//  JWDRecorderModel.m
//  JWD-AVFoundation-AudioRecorder-RecorderAndPlay
//
//  Created by 蒋伟东 on 2016/11/13.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "JWDRecorderModel.h"

#define TITLE_KEY          @"title"
#define URL_KEY            @"url"
#define DATE_STRING_KEY    @"dateString"
#define TIME_STRING_KEY    @"timeString"


@implementation JWDRecorderModel

+ (instancetype)memoWithTitle:(NSString *)title url:(NSURL *)url {
    return [[self alloc] initWithTitle:title url:url];
}

- (id)initWithTitle:(NSString *)title url:(NSURL *)url {
    self = [super init];
    if (self) {
        _title = [title copy];
        _url = url;
        
        NSDate *date = [NSDate date];
        _dateString = [self dateStringWithDate:date];
        _timeString = [self timeStringWithDate:date];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:TITLE_KEY];
    [coder encodeObject:self.url forKey:URL_KEY];
    [coder encodeObject:self.dateString forKey:DATE_STRING_KEY];
    [coder encodeObject:self.timeString forKey:TIME_STRING_KEY];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _title = [decoder decodeObjectForKey:TITLE_KEY];
        _url = [decoder decodeObjectForKey:URL_KEY];
        _dateString = [decoder decodeObjectForKey:DATE_STRING_KEY];
        _timeString = [decoder decodeObjectForKey:TIME_STRING_KEY];
    }
    return self;
}

- (NSString *)dateStringWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [self formatterWithFormat:@"MMddyyyy"];
    return [formatter stringFromDate:date];
}

- (NSString *)timeStringWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [self formatterWithFormat:@"HHmmss"];
    return [formatter stringFromDate:date];
}

- (NSDateFormatter *)formatterWithFormat:(NSString *)template {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *format = [NSDateFormatter dateFormatFromTemplate:template options:0 locale:[NSLocale currentLocale]];
    [formatter setDateFormat:format];
    return formatter;
}

- (BOOL)deleteMemo {
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtURL:self.url error:&error];
    if (!success) {
        NSLog(@"Unable to delete: %@", [error localizedDescription]);
    }
    return success;
}

@end
