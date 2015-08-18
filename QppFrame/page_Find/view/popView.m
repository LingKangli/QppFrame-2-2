//
//  popView.m
//  Example
//
//  Created by LingKangLi on 15/6/11.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "popView.h"
#import "Utill.h"

@implementation PopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{

//    if (self == nil) {
//
//    }
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =  [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        addFriendsBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        addFriendsBtn.layer.borderColor = [UIColor grayColor].CGColor;
        addFriendsBtn.layer.borderWidth = 1;
        addFriendsBtn.layer.cornerRadius = 10.0;
        addFriendsBtn.frame = CGRectMake(15, 15, UIScreenWidth*0.9, UIScreenHeight*0.05);
        addFriendsBtn.titleLabel.textColor = [UIColor blackColor];
        [addFriendsBtn setTitle:@"Add Friend" forState:UIControlStateNormal];
        [addFriendsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        addFriendsBtn.backgroundColor = [UIColor clearColor];
        [addFriendsBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];


        newGroupBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        newGroupBtn.layer.borderColor = [UIColor grayColor].CGColor;
        newGroupBtn.layer.borderWidth = 1;
        newGroupBtn.layer.cornerRadius = 10.0;
        newGroupBtn.frame = CGRectMake(addFriendsBtn.frame.origin.x, addFriendsBtn.frame.origin.y+addFriendsBtn.frame.size.height+10, UIScreenWidth*0.9, UIScreenHeight*0.05);
        newGroupBtn.titleLabel.textColor = [UIColor blackColor];
        [newGroupBtn setTitle:@"New Forder" forState:UIControlStateNormal];
        [newGroupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        newGroupBtn.backgroundColor = [UIColor clearColor];
        [newGroupBtn addTarget:self action:@selector(clickNew) forControlEvents:UIControlEventTouchUpInside];

        closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        closeBtn.layer.borderColor = [UIColor grayColor].CGColor;
        closeBtn.layer.borderWidth = 1;
        closeBtn.layer.cornerRadius = 10.0;
        closeBtn.frame = CGRectMake(newGroupBtn.frame.origin.x, newGroupBtn.frame.origin.y+newGroupBtn.frame.size.height+10, UIScreenWidth*0.9, UIScreenHeight*0.05);
        closeBtn.titleLabel.textColor = [UIColor blackColor];
        [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        closeBtn.backgroundColor = [UIColor clearColor];
        [closeBtn addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:addFriendsBtn];
        [self addSubview:newGroupBtn];
        [self addSubview:closeBtn];
        
    }

    return self;
}

-(void)click{

    NSLog(@"click");
}

-(void)clickNew{
    
    NSLog(@"clickNew");
}

-(void)clickClose{
    
    NSLog(@"clickClose");
    
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(0, UIScreenHeight, UIScreenWidth, UIScreenHeight*0.3);
    } completion:^(BOOL finished) {
        
    }];
}

@end
