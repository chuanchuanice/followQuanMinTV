//
//  NetManager.h
//  Day07_Hero
//
//  Created by tarena on 2017/1/7.
//  Copyright © 2017年 tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "TRRecommendModel.h"
#import "TRFocusModel.h"
#import "TRCategoryModel.h"
#import "TRLiveModel.h"
#import "TRLanMuModel.h"
#import "TRLanMuDetailModel.h"
#import "TRRoomModel.h"

@interface NetManager : BaseNetManager
/** 获取首页页面主体部分内容 */
+ (id)getRecommendCompletionHandler:(void(^)(TRRecommendModel *model, NSError *error))completionHandler;

/** 获取首页头部滚动广告 + 开机广告图片  */
+ (id)getFocusCompletionHandler:(void(^)(TRFocusModel *model, NSError *error))completionHandler;

/** 获取首页最上方滚动条, 推荐直播项目列表的 请求 */
+ (id)getCategoryCompletionHandler:(void(^)(NSArray<TRCategoryModel *> *list, NSError *error))completionHandler;

/** 获取直播列表 从0开始, 0 1 2 3...*/
+ (id)getLiveList:(NSInteger)page completionHandler:(void(^)(TRLiveModel *list, NSError *error))completionHandler;

/** 栏目 */
+ (id)getLanMuCompletionHandler:(void(^)(NSArray<TRLanMuModel *> *list, NSError *error))completionHandler;

/** 栏目详情 */
+ (id)getLanMuDetail:(NSInteger)page slug:(NSString *)slug completionHandler:(void(^)(TRLanMuDetailModel *model, NSError *error))completionHandler;

/** 房间详情 */
+ (id)getRoomInfo:(NSString *)uid completionHandler:(void(^)(TRRoomModel *room, NSError *error))completionHandler;
@end























