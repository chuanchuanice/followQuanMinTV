//
//  TRLanMuDetailVC.h
//  TRProject
//
//  Created by tarena on 2017/1/24.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRLanMuDetailVC : UICollectionViewController
- initWithSlug:(NSString *)slug;
@property (nonatomic) NSString *slug;
@end
