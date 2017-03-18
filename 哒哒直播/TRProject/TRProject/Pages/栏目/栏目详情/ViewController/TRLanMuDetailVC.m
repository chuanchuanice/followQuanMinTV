//
//  TRHomeShowVC.m
//  TRProject
//
//  Created by yingxin on 2017/1/23.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRLanMuDetailVC.h"
#import "TRHomeCell.h"
#import "TRPlayViewController.h"

@interface TRLanMuDetailVC ()
@property (nonatomic) TRLanMuDetailModel *detailModel;
@property (nonatomic) NSMutableArray<TRLanMuDetailDataModel *> *dataList;
@end

@implementation TRLanMuDetailVC

static NSString * const reuseIdentifier = @"Cell";

- (id)initWithSlug:(NSString *)slug{
    UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
    fl.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    fl.minimumLineSpacing = 10;
    fl.minimumInteritemSpacing = 10;
    CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 3 * 10) / 2);
    //390 219
    fl.itemSize = CGSizeMake(width, width * 219 / 390 + 25);
    self = [super initWithCollectionViewLayout:fl];
    if (self) {
        self.slug = slug;
        //当push操作时, 隐藏本页面的tabbar
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[TRHomeCell class] forCellWithReuseIdentifier:reuseIdentifier];
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [NetManager getLanMuDetail:0 slug:weakSelf.slug completionHandler:^(TRLanMuDetailModel *list, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMsg:@"error"];
            }else{
                [weakSelf.dataList removeAllObjects];
                _detailModel = list;
                [weakSelf.dataList addObjectsFromArray:list.data];
                [weakSelf.collectionView reloadData];
                if (list.total == list.size) {
                    [weakSelf.collectionView endFooterWithNoMore];
                }else{
                    [weakSelf.collectionView resetFooter];
                }
            }
        }];
    }];
    [self.collectionView beginHeaderRefresh];
    [self.collectionView addFooterRefresh:^{
        [NetManager getLanMuDetail:_detailModel.page+1 slug:weakSelf.slug completionHandler:^(TRLanMuDetailModel *list, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMsg:@"error"];
            }else{
                _detailModel = list;
                [weakSelf.dataList addObjectsFromArray:list.data];
                [weakSelf.collectionView reloadData];
                if (list.total == list.size) {
                    [weakSelf.collectionView endFooterWithNoMore];
                }
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    TRLanMuDetailDataModel *data = self.dataList[indexPath.row];
    [cell.iconIV setImageWithURL:data.thumb.yx_URL placeholder:@"img_yanzhi_content_default".yx_image];
    cell.titleLb.text = data.nick;
    cell.nameLb.text = data.title;
    cell.numLb.text = data.view;
    if (data.view.integerValue >= 10000) {
        cell.numLb.text = [NSString stringWithFormat:@"%.1f万", data.view.integerValue/10000.0];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TRLanMuDetailDataModel *data = self.dataList[indexPath.row];
    TRPlayViewController *vc = [[TRPlayViewController alloc] initWithRoomId:data.uid];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy

- (NSMutableArray<TRLanMuDetailDataModel *> *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSMutableArray<TRLanMuDetailDataModel *> alloc] init];
    }
    return _dataList;
}

@end
