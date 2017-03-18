//
//  TRLanMuDetailModel.m
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRLanMuDetailModel.h"

@implementation TRLanMuDetailModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data": @"TRLanMuDetailDataModel"};
}
@end
@implementation TRLanMuDetailDataModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"idd": @"id"};
}
@end


