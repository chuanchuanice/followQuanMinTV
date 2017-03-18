//
//  TRLanMuCell.m
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRLanMuCell.h"

@implementation TRLanMuCell
- (UILabel *)titleLb {
    if(_titleLb == nil) {
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(0);
            make.height.equalTo(2);
        }];
        
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lineView.mas_top).offset(-3);
            make.left.right.equalTo(0);
        }];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = @(15).yx_font;
        
    }
    return _titleLb;
}

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        CGFloat hw = 300 / 416.0;
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.width.equalTo(_iconIV.mas_height).multipliedBy(hw);
        }];
    }
    return _iconIV;
}

@end
