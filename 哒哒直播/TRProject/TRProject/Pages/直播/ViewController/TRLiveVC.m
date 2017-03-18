//
//  TRLiveVC.m
//  TRProject
//
//  Created by tarena on 2017/1/19.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRLiveVC.h"
#import "TRHomeCell.h"
#import "TRYanViewController.h"
#import "TRPlayViewController.h"

@interface TRLiveVC ()
@property (nonatomic) NSMutableArray<TRLiveDataModel *> *dataList;
@property (nonatomic) TRLiveModel *liveModel;
@end

@implementation TRLiveVC

static NSString * const reuseIdentifier = @"Cell";
#pragma mark - Life
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
    fl.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    fl.minimumLineSpacing = 10;
    fl.minimumInteritemSpacing = 10;
    CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 3 * 10) / 2);
    //390 219
    fl.itemSize = CGSizeMake(width, width * 219/390 + 20);
    self = [super initWithCollectionViewLayout:fl];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[TRHomeCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [NetManager getLiveList:0 completionHandler:^(TRLiveModel *list, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMsg:@"error"];
            }else{
                _liveModel = list;
                [weakSelf.dataList removeAllObjects];
                [weakSelf.dataList addObjectsFromArray:list.data];
                [weakSelf.collectionView reloadData];
                if (list.page == list.pageCount) {
                    [weakSelf.collectionView endFooterWithNoMore];
                }else{
                    [weakSelf.collectionView resetFooter];
                }
            }
        }];
    }];
    [self.collectionView beginHeaderRefresh];
    [self.collectionView addFooterRefresh:^{
        [NetManager getLiveList:_liveModel.page+1 completionHandler:^(TRLiveModel *list, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMsg:@"error"];
            }else{
                _liveModel = list;
                [weakSelf.dataList addObjectsFromArray:list.data];
                [weakSelf.collectionView reloadData];
                if (list.page == list.pageCount) {
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
    TRLiveDataModel *data = self.dataList[indexPath.row];
    [cell.iconIV setImageWithURL:data.thumb.yx_URL placeholder:@"img_content_default".yx_image];
    cell.nameLb.text = data.title;
    cell.titleLb.text = data.nick;
    cell.numLb.text = data.view;
    if (data.view.integerValue > 10000) {
        cell.numLb.text = [NSString stringWithFormat:@"%.1f万", data.view.integerValue / 10000.0];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TRLiveDataModel *data = self.dataList[indexPath.row];
    if (data.screen == 1) { //颜值
        TRYanViewController *vc = [[TRYanViewController alloc] initWithRoomId:data.uid];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        TRPlayViewController *vc = [[TRPlayViewController alloc] initWithRoomId:data.uid];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Lazy
- (NSMutableArray<TRLiveDataModel *> *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSMutableArray<TRLiveDataModel *> alloc] init];
    }
    return _dataList;
}

@end
