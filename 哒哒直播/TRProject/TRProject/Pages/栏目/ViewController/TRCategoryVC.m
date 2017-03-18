//
//  TRCategoryVC.m
//  TRProject
//
//  Created by tarena on 2017/1/19.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRCategoryVC.h"
#import "TRLanMuCell.h"
#import "TRHomeShowVC.h"
#import "TRLanMuDetailVC.h"

@interface TRCategoryVC ()
@property (nonatomic) NSArray<TRLanMuModel *> *dataList;
@end

@implementation TRCategoryVC

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - Life
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
    fl.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    fl.minimumLineSpacing = 10;
    fl.minimumInteritemSpacing = 10;
    CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 4 * 10) / 3);
    // 300 / 416.0;
    fl.itemSize = CGSizeMake(width, width * 416/300 + 30);
    if (self = [super initWithCollectionViewLayout:fl]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[TRLanMuCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [NetManager getLanMuCompletionHandler:^(NSArray<TRLanMuModel *> *list, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMsg:@"error"];
            }else{
                weakSelf.dataList = list;
                [weakSelf.collectionView reloadData];
            }
        }];
    }];
    [self.collectionView beginHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRLanMuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    TRLanMuModel *model = self.dataList[indexPath.row];
    [cell.iconIV setImageWithURL:model.image.yx_URL placeholder:@"img_content_default".yx_image];
    cell.titleLb.text = model.name;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TRLanMuModel *model = self.dataList[indexPath.row];
    if (model.screen == 1) {//正方形
        TRHomeShowVC *vc = [[TRHomeShowVC alloc] initWithSlug:model.slug];
        vc.title = model.name;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        TRLanMuDetailVC *vc = [[TRLanMuDetailVC alloc] initWithSlug:model.slug];
        vc.title = model.name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}






@end
