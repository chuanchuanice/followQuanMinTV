//
//  TRHomePageVC.m
//  TRProject
//
//  Created by yingxin on 2017/1/22.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRHomePageVC.h"
#import "TRRecommendVC.h"
#import "TRFoldBtn.h"
#import "TRHomeShowVC.h"
#import "TRLanMuDetailVC.h"
#import "TRLiveVC.h"

@interface TRHomePageVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic) NSArray<TRCategoryModel *> *dataList;
@property (nonatomic) UIView *rightView;
@property (nonatomic) UICollectionView *collectionView;
@end

@implementation TRHomePageVC
#pragma mark - Life
- (instancetype)init{
    if (self = [super init]) {
        self.menuBGColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeNormal = 15;
        self.menuBGColor = [UIColor whiteColor];
        self.titleSizeSelected = self.titleSizeNormal;
        self.titleColorNormal = [UIColor redColor];
        self.titleColorSelected = self.titleColorNormal;
        self.automaticallyCalculatesItemWidths = YES; //根据题目的内容自动算宽度
        self.itemMargin = 15; //题目的间距
        self.menuViewLayoutMode = WMMenuViewLayoutModeLeft; //题目左对齐 而不是平分
        self.navigationItem.titleView = @"img_nav_logo_zhibo".yx_imageView;
        self.menuHeight = 44;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetManager getCategoryCompletionHandler:^(NSArray<TRCategoryModel *> *list, NSError *error) {
        if (error) {
            [self.view showMsg:@"error"];
        }else{
            self.dataList = list;
            [self reloadData];
            //必须在reload之后调用, 否则会在刷新时被重置掉
            [self rightView];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
- (NSArray<NSString *> *)titles{
    if (self.dataList.count > 0) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        [tmpArr addObjectsFromArray:@[@"推荐", @"全部"]];
        [self.dataList enumerateObjectsUsingBlock:^(TRCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.is_default) {
                [tmpArr addObject:obj.name];
            }
        }];
        return tmpArr;
    }
    return @[@"推荐", @"全部"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    if (index == 0) {
        return [[TRRecommendVC alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    }
    if (index == 1) {
        return [[TRLiveVC alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    }
    if (index > 1) {
        NSString *title = self.titles[index];
        __block id vc = nil;
        [self.dataList enumerateObjectsUsingBlock:^(TRCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:title]) {
                if (obj.screen == 1) {//正方形
                    vc = [[TRHomeShowVC alloc] initWithSlug:obj.slug];
                }else{
                    vc = [[TRLanMuDetailVC alloc] initWithSlug:obj.slug];
                }
            }
        }];
        if (vc) {
            return vc;
        }
        
    }
    return [UIViewController new];
}

#pragma mark - Lazy

- (UIView *)rightView {
    if(_rightView == nil) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 44, 40)];
        self.menuView.rightView = _rightView;
        
        /*******  左侧的小阴影 *********/
        UIView *maskView = [UIView new];
        [_rightView addSubview:maskView];
        maskView.backgroundColor = [UIColor whiteColor];
        maskView.layer.shadowColor = [UIColor blackColor].CGColor;
        maskView.layer.shadowOffset = CGSizeMake(-2, 0);
        maskView.layer.shadowOpacity = 1;
        maskView.layer.shadowRadius = 3;
        [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(4);
            make.width.equalTo(1);
            make.height.equalTo(28);
        }];
        
        //自制控件, 有展开动画的按钮, 封装在 tools 文件夹下
        TRFoldBtn *foldBtn = [[TRFoldBtn alloc] initWithFrame:CGRectMake(4, 2, 40, 40)];
        [_rightView addSubview:foldBtn];
        
    }
    return _rightView;
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self.view addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

@end
