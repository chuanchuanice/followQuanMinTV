//
//  BaseNetManager.m
//  Day07_Hero
//
//  Created by tarena on 2017/1/7.
//  Copyright © 2017年 tarena. All rights reserved.
//

#import "BaseNetManager.h"

@implementation BaseNetManager

+ (id)GET:(NSString *)path param:(NSDictionary *)param completionHandler:(void (^)(id, NSError *))completionHandler{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //设置请求的超时时长, 默认60秒
    mgr.requestSerializer.timeoutInterval = 30;
    //request请求, 是值客户端给服务器发的
    //response响应, 指客户端响应服务器返回值的
    //强制的告诉AF框架, 把text/html类型的数据 当json解析
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    
    //block会自动回归到之前的线程.
    //自动把返回值进行json解析
    return [mgr GET:path parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //打印当前发送的请求地址, 方便调试
        NSLog(@"%@", task.currentRequest.URL.absoluteString);
        //网络请求+JSON解析 都成功
        !completionHandler ?: completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        !completionHandler ?: completionHandler(nil, error);
    }];
}

@end













