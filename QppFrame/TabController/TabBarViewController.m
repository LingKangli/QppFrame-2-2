//
//  TabBarViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//
#import "Utill.h"
#import "TabBarViewController.h"
#import "QppViewController.h"
#import "AddressBookViewController.h"
#import "FindViewController.h"
#import "MoreViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController
@synthesize tabVC = _tabVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.frame = CGRectMake(0, tabBarY, UIScreenWidth,tabBarHeight);
    self.tabBar.backgroundColor= [UIColor grayColor];

    // 改变tabBarController高度
//    UITabBarController *mTabBar = [[UITabBarController alloc] init];
//    self.tabBar.frame = CGRectMake(0, 460-40, 320, 40);
//    UIView * transitionView = [[self.view subviews] objectAtIndex:0];
//    transitionView.frame.size.height = 460-40;
//    transitionView.frame = CGRectMake(0, 460-40, 320, 40);

    //    self.tabBarItem
    
    //b.创建子控制器
    QppViewController* qppVC = [[QppViewController alloc]init];
    AddressBookViewController* addressBookVC = [[AddressBookViewController alloc]init];
    FindViewController* findVC = [[FindViewController alloc]init];
    MoreViewController* moreVC = [[MoreViewController alloc]init];

    UINavigationController* nav1 = [[UINavigationController alloc] initWithRootViewController:qppVC] ;//每个导航中加入了其对应的第一个controller
    UINavigationController* nav2 = [[UINavigationController alloc] initWithRootViewController:addressBookVC] ;
    UINavigationController* nav3 = [[UINavigationController alloc] initWithRootViewController:findVC] ;
    UINavigationController* nav4 = [[UINavigationController alloc] initWithRootViewController:moreVC] ;
    
    //将导航添加到数组中
    self.viewControllers = @[nav1,nav2,nav3,nav4];
    
    UITabBar* tabBar = self.tabBar;
    UITabBarItem* item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem* item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem* item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem* item3 = [tabBar.items objectAtIndex:3];
    
//    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"find.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem.image = [[UIImage imageNamed:@"find.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item0.image = [[UIImage imageNamed:@"Qpp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.imageInsets =UIEdgeInsetsMake(6, 6, -6, -6);
    item0.selectedImage = [[UIImage imageNamed:@"Qpp2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    item1.image = [[UIImage imageNamed:@"tongxulv.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.imageInsets =UIEdgeInsetsMake(6, 6, -6, -6);
    item1.selectedImage = [[UIImage imageNamed:@"tongxulv2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    item2.image = [[UIImage imageNamed:@"find.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"find2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.imageInsets =UIEdgeInsetsMake(6, 6, -6, -6);

    item3.image = [[UIImage imageNamed:@"more.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"more2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.imageInsets =UIEdgeInsetsMake(6, 6, -6, -6);

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
