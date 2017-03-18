//
//  TRRecommendVC.m
//  TRProject
//
//  Created by tarena on 2017/1/19.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRRecommendVC.h"
#import "TRHomeShowCell.h"
#import "TRHomeCell.h"
#import "TRHomeSectionHeaderView.h"
#import "TRTopAdCell.h"
#import "TRWebViewController.h"
#import "TRYanViewController.h"
#import "TRPlayViewController.h"

@interface TRRecommendVC ()<UICollectionViewDelegateFlowLayout, iCarouselDelegate, iCarouselDataSource>
@property (nonatomic) TRRecommendModel *recommendModel;
@property (nonatomic) NSArray<TRRecommendRoomModel *> *dataList;
//广告
@property (nonatomic) TRFocusModel *foucusModel;
@end

@implementation TRRecommendVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    [self.collectionView registerClass:[TRHomeCell class] forCellWithReuseIdentifier:@"TRHomeCell"];
    [self.collectionView registerClass:[TRHomeShowCell class] forCellWithReuseIdentifier:@"TRHomeShowCell"];
    [self.collectionView registerClass:[TRTopAdCell class] forCellWithReuseIdentifier:@"TRTopAdCell"];
    
    //注册组头和组脚
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    [self.collectionView registerClass:[TRHomeSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        //标记量, 监听两个请求同时完成的时间点. 因为下拉刷新这个状态必须是请求都结束以后, 再消失
        __block NSInteger count = 2;
        //获取头部滚动广告
        [NetManager getFocusCompletionHandler:^(TRFocusModel *model, NSError *error) {
            count--;
            //每完成一个请求, 则减去1, 因为两个请求是两个不同的线程, 根本无法预判哪个线程先结束. 所以分别在两个请求中判断count是否为0, 如果是0则表示两个请求都做完了!
            if (count == 0) [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMsg:@"error"];
            }else{
                _foucusModel = model;
                [weakSelf.collectionView reloadData];
            }
        }];
        
        //获取下方列表
        [NetManager getRecommendCompletionHandler:^(TRRecommendModel *model, NSError *error) {
            count--;
            if (count == 0) [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showMsg:@"error"];
            }else{
                /** 只显示 isDefault属性为真的元素. 观察原版app得到的规律 */
                NSMutableArray *tmpArr = [NSMutableArray new];
                [model.room enumerateObjectsUsingBlock:^(TRRecommendRoomModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.is_default) {
                        [tmpArr addObject:obj];
                    }
                }];
                _dataList = [tmpArr copy];
                
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

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //广告 144 x 44
    if (indexPath.section == 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 44 / 144);
    }
    
    
    //对比发现,同一个分组中可能存在不同screen的情况, 原版app的处理是, 让同一组元素都遵循组中第一个元素的样式
    if (_dataList[indexPath.section-1].list.firstObject.screen == 1) { //正方形
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 3 * 10) / 2);
        return CGSizeMake(width, width + 25);
    }else{
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 3 * 10) / 2);
        //390 219
        return CGSizeMake(width, width * 219 / 390 + 25);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(0, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    //组脚的大小, 宽度没用, 一定与CollectionView一样
    return CGSizeMake(0, 10);
}

#pragma mark <UICollectionViewDataSource>
//分组头和脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionFooter" forIndexPath:indexPath];
        UIView *lineView = [UIView new];
        [view addSubview:lineView];
        lineView.backgroundColor = [UIColor  colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        
        //注意翻看原版app, 每个分组之间的间隔是 浅灰色的. 这里使用的是组脚来制作的.
        //因为整个CollectionView的背景色是白色, 如果每个分割线都是10像素, 那么会导致向上拖拽到最下方时, 出现的颜色是白色. 不符合需求. 这里把组脚上的组视图规定800高度. 这明显特别高. 除了最后一个分组, 其它分组都切除掉这个超出的部分. 而最后一个分组不切除. 这样就不怕最下方的白色部分会漏出来了!
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(800);
        }];
        view.clipsToBounds = indexPath.section-1 != _dataList.count-1;
        return view;
    }else{
        TRHomeSectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        TRRecommendRoomModel *model = _dataList[indexPath.section-1];
        [view.iconIV setImageURL:model.icon.yx_URL];
        view.titleLb.text = model.name;
        return view;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //分组数量等于 广告 + 其它栏目的数量
    return _dataList.count + 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //如果是广告, 则只有一个cell
        return 1;
    }
    return _dataList[section-1].list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//如果是广告
        TRTopAdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRTopAdCell" forIndexPath:indexPath];
        cell.ic.delegate = self;
        cell.ic.dataSource = self;
        cell.pageC.numberOfPages = _foucusModel.focus.count;
        [cell.ic reloadData];
        return cell;
    }else{ //因为0分组是广告, 所以这个判断中的取值, 是从section=1 开始的, 我们要想从数组中拿值, 必须把 section-1 才可以
        //对比发现,同一个分组中可能存在不同screen的情况, 原版app的处理是, 让同一组元素都遵循组中第一个元素的样式
        TRRecommendRoomListModel *model = _dataList[indexPath.section-1].list[indexPath.row];
        if (_dataList[indexPath.section-1].list.firstObject.screen == 1) { //正方形
            TRHomeShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRHomeShowCell" forIndexPath:indexPath];
            [cell.iconIV setImageWithURL:model.thumb.yx_URL placeholder:@"img_yanzhi_content_default".yx_image];
            cell.titleLb.text = model.title;
            cell.addressLb.text = model.position;
            cell.nameLb.text = model.nick;
            cell.numLb.text = model.view;
            if (model.view.integerValue >= 10000) {
                cell.numLb.text = [NSString stringWithFormat:@"%.1f万", model.view.integerValue/10000.0];
            }
            return cell;
        }else{
            TRHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRHomeCell" forIndexPath:indexPath];
            [cell.iconIV setImageWithURL:model.thumb.yx_URL placeholder:@"img_yanzhi_content_default".yx_image];
            cell.titleLb.text = model.nick;
            cell.nameLb.text = model.title;
            cell.numLb.text = model.view;
            if (model.view.integerValue >= 10000) {
                cell.numLb.text = [NSString stringWithFormat:@"%.1f万", model.view.integerValue/10000.0];
            }
            return cell;
        }
        
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
    }else{
        TRRecommendRoomListModel *model = _dataList[indexPath.section-1].list[indexPath.row];
        if (model.screen == 1) {
            TRYanViewController *vc = [[TRYanViewController alloc] initWithRoomId:@(model.uid).stringValue];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            TRPlayViewController *vc = [[TRPlayViewController alloc] initWithRoomId:@(model.uid).stringValue];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

#pragma mark - iC Delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return _foucusModel.focus.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        UIImageView *iconIV = [UIImageView new];
        [view addSubview:iconIV];
        iconIV.tag = 100;
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    UIImageView *iconIV = [view viewWithTag:100];
    [iconIV setImageURL:_foucusModel.focus[index].thumb.yx_URL];
    [iconIV setImageWithURL:_foucusModel.focus[index].thumb.yx_URL placeholder:[UIImage imageNamed:@"img_home_banner_bg"]];
    
    return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    //carousel的父视图是 contentView, contentView的父视图是cell~
    TRTopAdCell *cell = (TRTopAdCell *)carousel.superview.superview;
    cell.pageC.currentPage = carousel.currentItemIndex;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    TRFocusFocusModel *model = _foucusModel.focus[index];
    if ([model.type isEqualToString:@"ad"]) {
        TRWebViewController *vc = [[TRWebViewController alloc] initWithURL:model.link.yx_URL];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([model.type isEqualToString:@"play"]) {
        //跳入到视频播放页面
        if (model.link_object.screen == 1) {
            TRYanViewController *vc = [[TRYanViewController alloc] initWithRoomId:model.link_object.uid];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            TRPlayViewController *vc = [[TRPlayViewController alloc] initWithRoomId:model.link_object.uid];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

@end
