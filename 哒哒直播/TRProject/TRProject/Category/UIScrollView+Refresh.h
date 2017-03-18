//
//  UIScrollView+Refresh.h
//  TRProject
//
//  Created by tarena on 2017/1/12.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface UIScrollView (Refresh)
- (void)addHeaderRefresh:(void(^)())block;
- (void)endHeaderRefresh;
- (void)beginHeaderRefresh;

- (void)addFooterRefresh:(void(^)())block;
- (void)endFooterRefresh;
- (void)endFooterWithNoMore;
- (void)resetFooter;

@end














