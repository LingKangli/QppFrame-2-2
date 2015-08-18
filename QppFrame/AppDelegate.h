//
//  AppDelegate.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSInteger testInt;
@property (nonatomic,strong)TabBarViewController* tabBar;

+ (AppDelegate *)sharedManager;
+ (UIWindow *)getWindow;
+(void)setWindowFrame;

@end

