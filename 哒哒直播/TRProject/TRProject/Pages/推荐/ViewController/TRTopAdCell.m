//
//  TRTopAdCell.m
//  TRProject
//
//  Created by tarena on 2017/2/4.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRTopAdCell.h"

@implementation TRTopAdCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //CollectionView 头部下拉时, 背景色是 灰色的
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = [UIColor  colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(0);
            make.height.equalTo(800);
        }];
    }
    return self;
}

- (iCarousel *)ic {
    if(_ic == nil) {
        _ic = [[iCarousel alloc] init];
        [self.contentView addSubview:_ic];
        _ic.scrollSpeed = .5;
        [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        [NSTimer scheduledTimerWithTimeInterval:3 block:^(NSTimer * _Nonnull timer) {
            [_ic scrollToItemAtIndex:_ic.currentItemIndex +1 animated:YES];
        } repeats:YES];
    }
    return _ic;
}

- (UIPageControl *)pageC {
    if(_pageC == nil) {
        [self ic];
        _pageC = [[UIPageControl alloc] init];
        [self.contentView addSubview:_pageC];
        [_pageC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(5);
        }];
    }
    return _pageC;
}
@end





