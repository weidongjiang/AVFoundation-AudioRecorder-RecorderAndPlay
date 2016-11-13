//
//  JWDRecorderCell.m
//  JWD-AVFoundation-AudioRecorder-RecorderAndPlay
//
//  Created by 蒋伟东 on 2016/11/13.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "JWDRecorderCell.h"
#import "Masonry.h"

@interface JWDRecorderCell ()

@property(nonatomic, strong)UILabel *title;//!< 标题
@property(nonatomic, strong)UILabel *curedate;//!< 录制日期
@property(nonatomic, strong)UILabel *recorderTime;//!< 时长
@end

@implementation JWDRecorderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUpUI];
        
        [self setEditing:YES animated:YES];
        
    }
    return self;
}

- (void)setUpUI {
    
    // 加控件
    self.title = [[UILabel alloc] init];
    [self.contentView addSubview:self.title];
    self.curedate = [[UILabel alloc] init];
    [self.contentView addSubview:self.curedate];
    self.recorderTime = [[UILabel alloc] init];
    [self.contentView addSubview:self.recorderTime];
    
    // 布局
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self.mas_left).offset (10);
    }];
    [self.curedate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    [self.recorderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self.curedate.mas_right);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
}

- (void)setModel:(JWDRecorderModel *)model {
    _model = model;
    
    _title.text = model.title;
    _curedate.text = model.dateString;
    _recorderTime.text = model.timeString;
}


@end
