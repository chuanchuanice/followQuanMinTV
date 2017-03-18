//
//  TRLiveModel.m
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRLiveModel.h"

@implementation TRLiveModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data": @"TRLiveDataModel"};
}

@end
@implementation TRLiveRecommendModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data": @"TRLiveRecommendDataModel"};
}
@end


@implementation TRLiveRecommendDataModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"idd": @"id"};
}
@end


@implementation TRLiveDataLinkModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"idd": @"id"};
}
@end


@implementation TRLiveDataModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"idd": @"id"};
}
@end


