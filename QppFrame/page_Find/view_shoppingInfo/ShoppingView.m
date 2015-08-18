//
//  ShoppingView.m
//  Example
//
//  Created by LingKangLi on 15/6/11.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "ShoppingView.h"
#import "Utill.h"

@implementation ShoppingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    
    self = [super init];
    if (self) {
        UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 20)];
        [backBtn setTitle:@"Back" forState:UIControlStateNormal];
        [self addSubview:backBtn];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = BackColor;
    if (self) {
        //Back button
        UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        //title
        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
        title.text = @"购物";
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self addSubview:title];
        
        //朋友圈内容
 
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, UIScreenHeight*0.15, UIScreenWidth, UIScreenHeight*0.9)];
        label.text = @"this is shopping page.";
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        
    }
    return self;
}

-(void)backBtn:(id) sender{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

-(void)addInfoBtn:(id) sender{
    
    
    
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

@end
