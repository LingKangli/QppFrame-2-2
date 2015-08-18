//
//  BaseUIViewController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseUIViewController : UIViewController

- (void)hideTabBar;
- (void)showTabBar;

- (void)hideNavBar;
- (void)showNavBar;

-(void)backToRootController;

@end
