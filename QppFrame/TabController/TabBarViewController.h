//
//  TabBarViewController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UITabBarController<UITabBarDelegate>

@property(strong,nonatomic) UITabBarController* tabVC;
- (void)hideTabBar ;

@end
