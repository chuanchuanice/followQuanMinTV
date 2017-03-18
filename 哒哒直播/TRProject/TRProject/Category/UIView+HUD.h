//
//  UIView+HUD.h
//  TRProject
//
//  Created by tarena on 2017/1/11.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (HUD)
- (void)showHUD;
- (void)hideHUD;
- (void)showMsg:(NSString *)msg;
@end












