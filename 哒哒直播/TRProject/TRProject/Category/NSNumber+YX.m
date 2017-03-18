//
//  NSNumber+YX.m
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "NSNumber+YX.h"

@implementation NSNumber (YX)
- (UIFont *)yx_font{
    return [UIFont systemFontOfSize:self.doubleValue];
}
@end
