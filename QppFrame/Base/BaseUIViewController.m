//
//  BaseUIViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "BaseUIViewController.h"
#import "Utill.h"

@implementation BaseUIViewController//父类controller

//隐藏此Controller下的TabBar
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

//显示此Controller下的TabBar
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    
//    contentView.frame = CGRectMake(0, 0, UIScreenWidth,800);

    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)hideNavBar{

    [self.navigationController setNavigationBarHidden:YES];//隐藏NavigationBar
 
}


- (void)showNavBar{
    [self.navigationController setNavigationBarHidden:NO];//隐藏NavigationBar

}


-(void)backToRootController{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
