//
//  TRTabBarController.m
//  TRProject
//
//  Created by tarena on 2017/1/19.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRTabBarController.h"
#import "TRLiveVC.h"
//#import "TRRecommendVC.h"
#import "TRHomePageVC.h"
#import "TRCategoryVC.h"
#import "TRMineViewController.h"

@interface TRTabBarController ()

@end

@implementation TRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UINavigationBar appearance].translucent = NO;
    [UITabBar appearance].translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:166/255.0  green:166/255.0  blue:166/255.0 alpha:.6]} forState:UIControlStateNormal];
    [UIImageView appearance].contentMode = UIViewContentModeScaleAspectFill;
    [UIImageView appearance].clipsToBounds = YES;
    
    
    
    
    TRLiveVC *liveVC = [[TRLiveVC alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    liveVC.title = @"直播";
    liveVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_live_default"];
    liveVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_live_selected"];
    UINavigationController *liveNavi = [[UINavigationController alloc] initWithRootViewController:liveVC];
    
    TRCategoryVC *categoryVC = [[TRCategoryVC alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    categoryVC.title = @"栏目";
    categoryVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_follow_default"];
    categoryVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_follow_selected"];
    UINavigationController *categoryNavi = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    
    TRHomePageVC *homeVC = [TRHomePageVC new];
    homeVC.tabBarItem.title = @"首页";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_home_default"];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [UICollectionView appearance].backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    
    //从故事板中 初始化 id 是 "TRMineViewController" 的场景, 注意如果这个场景关联了类, 这个类中不要写代理方法(因为默认创建的继承于UITableViewController的类是有代理方法的, 且返回的分组数量为0), 会导致静态表格失效.
    TRMineViewController *mineVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TRMineViewController"];
    mineVC.title = @"我的";
    mineVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_mine_default"];
    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mine_selected"];
    UINavigationController *miniNavi = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    self.viewControllers = @[homeNavi, categoryNavi, liveNavi, miniNavi];
    
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

@end
