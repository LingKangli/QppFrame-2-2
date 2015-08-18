//
//  BiaoQingView.m
//  Example
//
//  Created by LingKangLi on 15/6/12.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "BiaoQingView.h"
#import "Utill.h"
#import "BiaoPingCellTableViewCell.h"
#import "BiaoQingView.h"

#import "SettingView.h"

@implementation BiaoQingView

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

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = BackColor;
    if (self) {
        //Back button
//        UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
//        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//        [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:backBtn];
        
        //title
//        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
//        title.text = @"表情";
//        title.textColor = [UIColor whiteColor];
//        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
//        [self addSubview:title];
//        
//        UIImageView* expImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height, UIScreenWidth, UIScreenHeight*0.2)];
//        expImg.image = [UIImage imageNamed:@"titleBack.png"];
//        [self addSubview:expImg];
//        
        
       
        
//        NSArray* nameLabArray;//名字数组
//        NSArray* contentLabArray;//聊天信息数组
//        NSArray* isDownImgNameArray;//下载按钮图片数组
        
//        ChatRecordView * cRV = [[ChatRecordView alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height+10, UIScreenWidth, UIScreenHeight*0.8)];
//        [self addSubview:cRV];
    }
    return self;
}




@end
