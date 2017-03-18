//
//  TRLanMuModel.h
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class Esarray;
@interface TRLanMuModel : NSObject

//@property (nonatomic, strong) NSArray<Esarray *> *esArray;
//
//@end
//@interface Esarray : NSObject

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *first_letter;

@property (nonatomic, assign) NSInteger status;
//id -> idd
@property (nonatomic, assign) NSInteger idd;

@property (nonatomic, assign) NSInteger prompt;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *name;

@end

