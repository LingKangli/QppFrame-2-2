//
//  HeadView.m
//  Example
//
//  Created by LingKangLi on 15/6/12.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "HeadView.h"
#import "Utill.h"

@implementation HeadView

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
        //        UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 20)];
        //        [backBtn setTitle:@"Back" forState:UIControlStateNormal];
        //        [self addSubview:backBtn];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = BackColor;
    if (self) {
        //头部背景图片
        UIImageView* titleImgBG = [[UIImageView alloc]initWithFrame:frame];
        titleImgBG.image = [UIImage imageNamed:@"titleBG.png"];
        [self addSubview:titleImgBG];
        
        //头部标题背景
        UILabel* titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight*0.1)];
        titleLab.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
        [self addSubview:titleLab];
        
        //title
        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, titleY, UIScreenWidth*0.3, titleHeight)];
        title.text = @"个人中心";
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self addSubview:title];
        
        //头像部分（叠加部分透明是否可以做？）
        UIImageView* perBGImg = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, titleLab.frame.origin.y+titleLab.frame.size.height+20, 62 , 62)];
        perBGImg.image = [UIImage imageNamed:@"u378.png"];
        [self addSubview:perBGImg];
        
        UIImageView* perImg = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 60, 60)];
        perImg.image = [UIImage imageNamed:@"u380.png"];
        [perBGImg addSubview:perImg];
        
        
    }
    return self;
}





//-(void)backBtn:(id) sender{
//    [UIView animateWithDuration:0.6 animations:^{
//        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
//    } completion:^(BOOL finished) {
//        
//        [self removeFromSuperview];
//        
//    }];
//    
//}

//-(void)addInfoBtn:(id) sender{
//    [UIView animateWithDuration:0.6 animations:^{
//        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        
//    }];
//}
@end
