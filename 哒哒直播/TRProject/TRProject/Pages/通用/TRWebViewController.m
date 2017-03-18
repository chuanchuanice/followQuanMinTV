//
//  TRWebViewController.m
//  TRProject
//
//  Created by tarena on 2017/2/4.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRWebViewController.h"

@interface TRWebViewController ()<UIWebViewDelegate>
@property (nonatomic) UIWebView *webView;
@end

@implementation TRWebViewController

- (id)initWithURL:(NSURL *)webURL{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        _webURL = webURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [UIWebView new];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:_webURL]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view showHUD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view showMsg:error.localizedDescription];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
