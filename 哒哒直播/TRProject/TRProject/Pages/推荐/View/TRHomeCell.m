//
//  TRHomeCell.m
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRHomeCell.h"

@implementation TRHomeCell
- (UILabel *)numLb {
    if(_numLb == nil) {
        _numLb = [[UILabel alloc] init];
        [self.contentView addSubview:_numLb];
        _numLb.textColor = [UIColor darkGrayColor];
        _numLb.font = @(14).yx_font;
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

- (UILabel *)nameLb {
    if(_nameLb == nil) {
        UIImageView *bottomShadow = @"img_yanzhikong_zhezhao".yx_imageView;
        [self.iconIV addSubview:bottomShadow];
        [bottomShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(0);
            make.height.equalTo(18);
        }];

        
        _nameLb = [[UILabel alloc] init];
        [bottomShadow addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.right.equalTo(-5);
            make.centerY.equalTo(0);
        }];
        _nameLb.textColor = [UIColor whiteColor];
        _nameLb.font = @(12).yx_font;
    }
    return _nameLb;
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
        //219/390
        CGFloat hw = 390/219.0;
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.width.equalTo(_iconIV.mas_height).multipliedBy(hw);
        }];
        _iconIV.layer.cornerRadius = 2;
    }
    return _iconIV;
}
@end












