//
//  DefineBG.m
//  Example
//
//  Created by LingKangLi on 15/6/13.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "DefineBG.h"
#import "Utill.h"


#define SpaceWhideth UIScreenWidth
#define SpaceHeight UIScreenHeight*0.08


@implementation DefineBG

@synthesize labTitle = _labTitle;
@synthesize textField = _textField;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.frame = frame;
    
    _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, UIScreenWidth*0.3, SpaceHeight)];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(_labTitle.frame.origin.x+_labTitle.frame.size.width, _labTitle.frame.origin.y, UIScreenWidth*0.6, SpaceHeight)];
    
    [self addSubview:_labTitle];
    [self addSubview:_textField];
    
//    [self addSubview:lab];
    return self;
}


@end
