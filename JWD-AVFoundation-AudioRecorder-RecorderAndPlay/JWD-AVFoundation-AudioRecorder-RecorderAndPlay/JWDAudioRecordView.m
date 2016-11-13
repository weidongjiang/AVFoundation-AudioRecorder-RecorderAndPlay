//
//  JWDAudioRecordView.m
//  JWD-AVFoundation-AudioRecorder-RecorderAndPlay
//
//  Created by 蒋伟东 on 2016/11/13.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "JWDAudioRecordView.h"

@interface JWDAudioRecordView ()


@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UIImageView *micImageView;
@property (nonatomic, strong) UIImageView *volumeImageView;
@property (nonatomic, strong) UILabel     *markLabel;
@property (nonatomic, strong) UIImageView *cancelImageView;
@property (nonatomic, strong) UIImageView *tooLongImageView;
@property (nonatomic, strong) UIImageView *tooShartImageView;

@end


@implementation JWDAudioRecordView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {

    self.backView.frame = CGRectMake((self.frame.size.width - 156)/2.0, (self.frame.size.width - 160)/2.0, 156, 160);
    [self addSubview:self.backView];
    
    self.micImageView.frame = CGRectMake(40, 25, 35, 70);
    self.volumeImageView.frame = CGRectMake(self.backView.frame.size.width - 40 - 12, 45, 12, 42);
    [self.backView addSubview:self.micImageView];
    [self.backView addSubview:self.volumeImageView];
    
    self.micImageView.frame = CGRectMake((self.backView.frame.size.width -44)/2.0, 25, 44, 65);
    [self.backView addSubview:self.micImageView];
    
    self.markLabel.frame = CGRectMake((self.backView.frame.size.width - 126)/2.0, self.backView.frame.size.height - 15 - 30, 126, 30);
    [self.backView addSubview:self.markLabel];
    
    self.cancelImageView.frame = CGRectMake((self.backView.frame.size.width - 45)/2.0, 25, 45, 56);
    [self.backView addSubview:self.cancelImageView];
    
    self.tooLongImageView.frame = CGRectMake((self.frame.size.width - 120)/2.0, (self.frame.size.height - 120)/2.0, 120, 120);
    
    CGFloat backViewW = self.backView.frame.size.width;
    CGFloat backViewH = self.backView.frame.size.height;
    CGFloat markLabelY = self.markLabel.frame.origin.y;
    
//    self.numCountDownImageView.frame = CGRectMake((backViewW-39)*0.5, (markLabelY - 51)*0.5, 39, 51);
//    self.numCountDownImageView.image = [UIImage imageNamed:@"YXLiveChatRecordCountDown_9"];
//    [self.backView addSubview:self.numCountDownImageView];

    

}

-(void)updateRecordView:(double)level {

    double lowPassResults = level;
    NSLog(@"%lf",lowPassResults);
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.06) {
        [self.volumeImageView setImage:[UIImage imageNamed:@"RecordingSignal001"]];
    }else if (0.06<lowPassResults<=0.1) {
        [self.volumeImageView setImage:[UIImage imageNamed:@"RecordingSignal002"]];
    }else if (0.1<lowPassResults<=0.14) {
        [self.volumeImageView setImage:[UIImage imageNamed:@"RecordingSignal003"]];
    }else if (0.14<lowPassResults<=0.18) {
        [self.volumeImageView setImage:[UIImage imageNamed:@"RecordingSignal004"]];
    }else if (0.18<lowPassResults<=0.22) {
        [self.volumeImageView setImage:[UIImage imageNamed:@"RecordingSignal005"]];
    }else if (0.22<lowPassResults<=0.26) {
        [self.volumeImageView setImage:[UIImage imageNamed:@"RecordingSignal006"]];
    }else if (0.30<lowPassResults<=0.34) {
        [self.volumeImageView setImage:[UIImage imageNamed:@"RecordingSignal007"]];
    }else {
        [self.volumeImageView setImage:[UIImage imageNamed:@"RecordingSignal008"]];
    }

}
- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _backView.layer.cornerRadius = 4;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UIImageView *)micImageView {
    if (_micImageView == nil) {
        _micImageView = [[UIImageView alloc] init];
        _micImageView.image = [UIImage imageNamed:@"YXLiveChatRecordingBkg"];//50*100
        [_micImageView sizeToFit];
    }
    return _micImageView;
}

- (UIImageView *)volumeImageView {
    if (_volumeImageView == nil) {
        _volumeImageView = [[UIImageView alloc] init];//18*60
    }
    return _volumeImageView;
}

- (UIImageView *)cancelImageView {
    if (_cancelImageView == nil) {
        _cancelImageView = [[UIImageView alloc] init];
        _cancelImageView.image = [UIImage imageNamed:@"YXLiveChatRecordCancel"];//100*100
        _cancelImageView.hidden = YES;
        [_cancelImageView sizeToFit];
    }
    return _cancelImageView;
}


- (UIImageView *)tooLongImageView {
    if (_tooLongImageView == nil ) {
        _tooLongImageView = [[UIImageView alloc] init];
        _tooLongImageView.image = [UIImage imageNamed:@"Record_overlong"];//90*90
        _tooLongImageView.hidden = YES;
    }
    return _tooLongImageView;
}


- (UILabel *)markLabel {
    if (_markLabel == nil) {
        _markLabel = [[UILabel alloc] init];
        _markLabel.text = @"手指上滑,取消发送";
        _markLabel.textColor = [UIColor whiteColor];
        _markLabel.font = [UIFont boldSystemFontOfSize:14];
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.backgroundColor = [UIColor clearColor];
        _markLabel.layer.cornerRadius = 3;
        _markLabel.layer.masksToBounds = YES;
    }
    return _markLabel;
}

@end
