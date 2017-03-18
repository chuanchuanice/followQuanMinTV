//
//  TRHomeShowCell.m
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRHomeShowCell.h"

@implementation TRHomeShowCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self iconIV];
    }
    return self;
}

- (UILabel *)numLb {
    if(_numLb == nil) {
        _numLb = [[UILabel alloc] init];
        [self.contentView addSubview:_numLb];
        _numLb.textColor = [UIColor darkGrayColor];
        _numLb.font = @(13).yx_font;
        [_numLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.bottom.equalTo(0);
        }];
        
        UIImageView *iconIV = @"audienceCount".yx_imageView;
        [self.contentView addSubview:iconIV];
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_numLb);
            make.right.equalTo(_numLb.mas_left).offset(-5);
            make.left.greaterThanOrEqualTo(self.titleLb.mas_right).offset(5);
        }];
        
    }
    return _numLb;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        _titleLb.textColor = [UIColor darkGrayColor];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.bottom.equalTo(0);
        }];
        _titleLb.font = @(14).yx_font;
        
    }
    return _titleLb;
}

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.width.equalTo(_iconIV.mas_height);
        }];
        _iconIV.layer.cornerRadius = 2;
        
        UIImageView *shadow = @"sy_location_shadow".yx_imageView;
        [_iconIV addSubview:shadow];
        [shadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(0);
        }];
        
        UIImageView *bottomShadow = @"img_yanzhikong_zhezhao".yx_imageView;
        [_iconIV addSubview:bottomShadow];
        [bottomShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(0);
            make.height.equalTo(18);
        }];
        
        _addressLb = [UILabel new];
        [shadow addSubview:_addressLb];
        _addressLb.textColor = [UIColor whiteColor];
        _addressLb.font = @(14).yx_font;
        [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.centerY.equalTo(0);
        }];
        
        UIImageView *locationIcon = @"Locationg".yx_imageView;
        [shadow addSubview:locationIcon];
        [locationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_addressLb.mas_left).offset(-5);
            make.centerY.equalTo(0);
        }];
        
        
        _nameLb = [UILabel new];
        _nameLb.font = @(13).yx_font;
        [bottomShadow addSubview:_nameLb];
        _nameLb.textColor = [UIColor whiteColor];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.right.equalTo(-5);
            make.centerY.equalTo(0);
        }];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        
    }
    return _iconIV;
}
@end












