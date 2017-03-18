//
//  TRFoldBtn.h
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRFoldBtn : UIView
@property (nonatomic) UIImageView *iconIV;
@property (nonatomic) BOOL fold;

@property (nonatomic) void(^foldAction)(BOOL fold);

@end
