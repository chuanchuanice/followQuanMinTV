//
//  TRRecommendModel.m
//  TRProject
//
//  Created by tarena on 2017/1/22.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRRecommendModel.h"

@implementation TRRecommendModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"room": @"TRRecommendRoomModel"};
}
@end

@implementation TRRecommendRoomModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list": @"TRRecommendRoomListModel"};
}
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"idd": @"id"};
}
@end


@implementation TRRecommendRoomListModel

@end


