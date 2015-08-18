//
//  Chat.m
//  Example
//
//  Created by LingKangLi on 15/6/11.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "ChatView.h"
#import "Utill.h"
#import "ChatRecordView.h"
#import "SendMessageView.h"

#import "MessageInputView/XHMessageInputView.h"

@implementation ChatView
//@synthesize backBtn;
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
              
//        ChatRecordView * cRV = [[ChatRecordView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight*0.78)];
//        cRV.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
//        [self addSubview:cRV];
        
        
//        SendMessageView* sendView = [[SendMessageView alloc]initWithFrame:CGRectMake(0, cRV.frame.size.height+cRV.frame.origin.y, UIScreenWidth, UIScreenHeight*0.3)];
//        sendView.backgroundColor= [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
//        [self addSubview:sendView];
        
    }
    return self;
}

//-(void)backBtn:(id) sender{
//    [UIView animateWithDuration:0.6 animations:^{
//        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//
//    }];
//
    
//    [self.navigationController popToRootViewController］;
//}

@end
