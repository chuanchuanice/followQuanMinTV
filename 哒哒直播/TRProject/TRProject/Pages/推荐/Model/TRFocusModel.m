//
//  TRFocusModel.m
//  TRProject
//
//  Created by tarena on 2017/1/22.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRFocusModel.h"

@implementation TRFocusModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"launchImage": @"TRFocusLaunchModel",
             @"focus": @"TRFocusFocusModel"};
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"launchImage": @"ios-launch-image",
             @"focus": @"ios-focus"};
}
@end

@implementation TRFocusLaunchModel

@end




@implementation TRFocusFocusExtModel

@end


@implementation TRFocusFocusLinkModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"idd": @"id"};
}
@end


@implementation TRFocusFocusModel

@end




