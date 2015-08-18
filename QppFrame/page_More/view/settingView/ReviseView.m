//
//  reviseView.m
//  Example
//
//  Created by LingKangLi on 15/6/13.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "ReviseView.h"
#import "Utill.h"
#import "DefineBG.h"
@implementation ReviseView

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
        title.text = @"修改密码";
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self addSubview:title];
        
        //Back button
        UIButton* yesBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth*0.8, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
        [yesBtn setTitle:@"完成" forState:UIControlStateNormal];
        [yesBtn addTarget:self action:@selector(yesBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yesBtn];
        
        UIView* bgColor = [[UIView alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height, UIScreenWidth, UIScreenHeight)];
        bgColor.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
        [self addSubview:bgColor];

        
        DefineBG* oldScrTitle = [[DefineBG alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height+10, UIScreenWidth, UIScreenHeight*0.08)];
        oldScrTitle.labTitle.text = @"旧密码";
        oldScrTitle.textField.backgroundColor = [UIColor clearColor];
        [self addSubview:oldScrTitle];
        
        DefineBG* newScrTitle = [[DefineBG alloc]initWithFrame:CGRectMake(0, oldScrTitle.frame.origin.y+oldScrTitle.frame.size.height+1, UIScreenWidth, UIScreenHeight*0.08)];
        newScrTitle.labTitle.text = @"新密码";
        newScrTitle.textField.backgroundColor = [UIColor clearColor];
        [self addSubview:newScrTitle];
        
        DefineBG* enterScrTitle = [[DefineBG alloc]initWithFrame:CGRectMake(0, newScrTitle.frame.origin.y+newScrTitle.frame.size.height+1, UIScreenWidth, UIScreenHeight*0.08)];
        enterScrTitle.labTitle.text = @"确认密码";
        enterScrTitle.textField.backgroundColor = [UIColor clearColor];
        [self addSubview:enterScrTitle];
    }
    return self;
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return [findContent count];
//}

-(void)backBtn:(id) sender{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

-(void)yesBtn:(id) sender{
    /*
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth*0.3, UIScreenHeight*0.3)];
    view.backgroundColor = [UIColor redColor];
    
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    */
    
    timer=[NSTimer scheduledTimerWithTimeInterval:3
                                           target:self
                                         selector:@selector(showArrow)
                                         userInfo:nil
                                          repeats:YES];
    
}

-(void)showArrow{
    UIView *arrow =[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 40)];
    arrow.backgroundColor = [UIColor redColor];
    [UIView beginAnimations:@"ShowArrow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(showArrowDidStop:finished:context:)];
    // Make the animatable changes.
    arrow.alpha = 1.0;
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
}
// Called at the end of the preceding animation.

- (void)showArrowDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context

{
    UIImageView *arrow =( UIImageView *) [self viewWithTag:101];
    [UIView beginAnimations:@"HideArrow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:1.0];
    arrow.alpha = 1.0;
    [UIView commitAnimations];
    
}
@end
