//
//  TRHomeShowVC.h
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRHomeShowVC : UICollectionViewController

- (id)initWithSlug:(NSString *)slug;
@property (nonatomic) NSString *slug;
@end
