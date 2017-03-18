//
//  TRRoomModel.m
//  TRProject
//
//  Created by tarena on 2017/2/3.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRRoomModel.h"

@implementation TRRoomModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"room_lines": @"TRRoomLinesModel",
             @"rank_curr": @"TRRoomRankCurrModel"};
}
@end
@implementation TRRoomLiveModel

@end


@implementation TRRoomLiveWsModel

@end


@implementation TRRoomLiveWsHFModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"three": @"3",
             @"four": @"4",
             @"five": @"5"};
}
@end



@implementation TRRoomRankCurrModel

@end


@implementation TRRoomLinesModel

@end


@implementation TRRoomLiveWsHFDetailModel

@end






