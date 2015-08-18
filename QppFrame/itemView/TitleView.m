//
//  TitleView.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "TitleView.h"
#import "Utill.h"

@implementation TitleView
@synthesize leftBtn;
@synthesize rightBtn;
@synthesize titleLab;
@synthesize returnBtn;


#define titleItemY -10


-(instancetype)init{

    self = [super init];
    if (self) {
        titleLab = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, 5, 100, 30)];
        titleLab.textColor = [UIColor whiteColor];
//        titleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
//        titleLab.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:titleLab];
        
        rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth/2+120, 5, 40, 30)];
        [self addSubview:rightBtn];
        
        leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 40, titleHeight)];
       
        [self addSubview:leftBtn];
        
        returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,5, 40, 30)];
        
        [returnBtn setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
        [self addSubview:returnBtn];

        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        titleLab = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-30, 5+titleY, 300, titleHeight)];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = titlePage;
        [self addSubview:titleLab];
        
        rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth/2+120, 35+titleY, 40, titleHeight)];
        [self addSubview:rightBtn];
        
        leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, titleY, 60, titleHeight)];
        [self addSubview:leftBtn];
        
        returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, titleY+20, 10, 20)];
        [returnBtn setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
        [self addSubview:returnBtn];

    }
    return self;
}

@end
