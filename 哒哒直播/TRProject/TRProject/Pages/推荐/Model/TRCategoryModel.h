//
//  TRCategoryModel.h
//  TRProject
//
//  Created by yingxin on 2017/1/22.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class Esarray;
@interface TRCategoryModel : NSObject
//
//@property (nonatomic, strong) NSArray<Esarray *> *esArray;
//
//@end
//@interface Esarray : NSObject

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger is_default;
//id -> idd
@property (nonatomic, assign) NSInteger idd;

@property (nonatomic, copy) NSString *icon_image;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, copy) NSString *icon_red;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon_gray;

@end

