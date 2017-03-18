//
//  TRFoldBtn.m
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRFoldBtn.h"

@implementation TRFoldBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self iconIV];
        _fold = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            if (_fold) {
                [self unfoldImage];
            }else{
                [self foldImage];
            }
            _fold = !_fold;
            !_foldAction ?: _foldAction(_fold);
        }];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)foldImage{
    //这个写法, 系统会自动寻找img_tap_btn_helong0, img_tap_btn_helong1, img_tap_btn_helong2, img_tap_btn_helong3 ......, 直到找不到为止. 然后把这些图片组合成一个动画.
    UIImage *image = [UIImage animatedImageNamed:@"img_tap_btn_helong" duration:.5];
    self.iconIV.image = image;
    //测试了下, 如果是.5的话, 动画会刚好执行第二次的一个开头. 会有闪烁的现象
    [NSTimer bk_scheduledTimerWithTimeInterval:.4 block:^(NSTimer *timer) {
        self.iconIV.image = @"img_tap_btn_zhankai1".yx_image;
    } repeats:NO];
}

- (void)unfoldImage{
    UIImage *image = [UIImage animatedImageNamed:@"img_tap_btn_zhankai" duration:.5];
    self.iconIV.image = image;
    [NSTimer bk_scheduledTimerWithTimeInterval:.4 block:^(NSTimer *timer) {
        self.iconIV.image = @"img_tap_btn_helong1".yx_image;
    } repeats:NO];
}

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        [self addSubview:_iconIV];
        _iconIV.frame = self.bounds;
        _iconIV.image = @"img_tap_btn_helong1".yx_image;
        _iconIV.contentMode = UIViewContentModeCenter;
    }
    return _iconIV;
}


@end









