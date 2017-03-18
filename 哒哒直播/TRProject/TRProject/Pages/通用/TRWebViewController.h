//
//  TRWebViewController.h
//  TRProject
//
//  Created by tarena on 2017/2/4.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRWebViewController : UIViewController
- initWithURL:(NSURL *)webURL;
@property (nonatomic) NSURL *webURL;
@end
