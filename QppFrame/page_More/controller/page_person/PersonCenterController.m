//
//  PersonCenterController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "PersonCenterController.h"
#import "PersonCenterView.h"
#import "Utill.h"

@implementation PersonCenterController

-(void)viewDidLoad{

    [self hideTabBar];
    [super viewDidLoad];
    PersonCenterView* pCV = [[PersonCenterView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self.view addSubview:pCV];

    //Back button
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, titleY, UIScreenWidth*0.2, titleHeight)];
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
