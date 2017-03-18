//
//  NetManager.m
//  Day07_Hero
//
//  Created by tarena on 2017/1/7.
//  Copyright © 2017年 tarena. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager
+ (id)getRecommendCompletionHandler:(void (^)(TRRecommendModel *, NSError *))completionHandler{
    NSString *path = @"http://www.quanmin.tv/json/app/index/recommend/list-iphone.json?0119144410";
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([TRRecommendModel parse:obj], error);
    }];
}

+ (id)getFocusCompletionHandler:(void (^)(TRFocusModel *, NSError *))completionHandler{
    NSString *path = @"http://www.quanmin.tv/json/page/app_images?p=2&rid=-1&rcat=-1&uid=1826550118&screen=2&device=57D88898-C7D0-4FEE-9D81-79539A61DE6D&sw=320.0&sh=568.0&ch=APPStore&refer=";
    return [self GET:path
               param:nil
   completionHandler:^(id obj, NSError *error) {
       !completionHandler ?: completionHandler([TRFocusModel parse:obj], error);
   }];
}

+ (id)getCategoryCompletionHandler:(void (^)(NSArray<TRCategoryModel *> *, NSError *))completionHandler{
    NSString *path = @"http://www.quanmin.tv/json/app/index/category/info-iphone.json";
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([TRCategoryModel parse:obj], error);
    }];
}

+ (id)getLiveList:(NSInteger)page completionHandler:(void (^)(TRLiveModel *, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:@"http://www.quanmin.tv/json/play/list.json"];
    if (page > 0) {
        path = [NSString stringWithFormat:@"http://www.quanmin.tv/json/play/list_%ld.json", page];
    }
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([TRLiveModel parse:obj], error);
    }];
}

+ (id)getLanMuCompletionHandler:(void (^)(NSArray<TRLanMuModel *> *, NSError *))completionHandler{
    NSString *path = @"http://www.quanmin.tv/json/categories/list.json";
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([TRLanMuModel parse:obj], error);
    }];
}

+ (id)getLanMuDetail:(NSInteger)page slug:(NSString *)slug completionHandler:(void (^)(TRLanMuDetailModel *, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:@"http://www.quanmin.tv/json/categories/%@/list.json?0119145715", slug];
    if (page > 0) {
        path = [NSString stringWithFormat:@"http://www.quanmin.tv/json/categories/%@/list_%ld.json?0119145715", slug, page];
    }
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([TRLanMuDetailModel parse:obj], error);
    }];
}

+ (id)getRoomInfo:(NSString *)uid completionHandler:(void (^)(TRRoomModel *, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:@"http://www.quanmin.tv/json/rooms/%@/info.json", uid];
    return [self GET:path param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([TRRoomModel parse:obj], error);
    }];
}
@end











