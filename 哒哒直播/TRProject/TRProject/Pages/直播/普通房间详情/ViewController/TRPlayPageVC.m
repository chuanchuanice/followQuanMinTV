//
//  TRPlayPageVC.m
//  TRProject
//
//  Created by tarena on 2017/2/6.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRPlayPageVC.h"

@interface TRPlayPageVC ()

@end

@implementation TRPlayPageVC

- (NSArray<NSString *> *)titles{
    return @[@"聊天", @"排行", @"主播"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    NSArray *colors = @[[UIColor brownColor],
                        [UIColor blueColor],
                        [UIColor orangeColor]];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = colors[index];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
