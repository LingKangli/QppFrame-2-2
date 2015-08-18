//
//  SettingController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "SettingController.h"
#import "SettingView.h"
#import "Utill.h"

@implementation SettingController

-(void)viewDidLoad{
    
    [self hideTabBar];
    [super viewDidLoad];
    SettingView* pCV = [[SettingView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self.view addSubview:pCV];
    
    //Back button
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
}

-(void)backBtn:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self showTabBar];
    NSLog(@"aaa");
}
@end
