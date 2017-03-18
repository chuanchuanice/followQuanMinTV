//
//  NSObject+Parse.h
//  Day07_Hero
//
//  Created by tarena on 2017/1/7.
//  Copyright © 2017年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit.h>
//遵循协议之后, 关于数组 和 变化的属性值 的对应方法有代码提示
@interface NSObject (Parse)<YYModel>
+ (id)parse:(id)JSON;
@end















