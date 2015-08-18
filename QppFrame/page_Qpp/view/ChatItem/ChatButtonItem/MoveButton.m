
//
//  LifeButton.m
//  KeyBorad
//
//  Created by LingKangLi on 15/7/3.
//  Copyright (c) 2015年 fengdu. All rights reserved.
//

#import "MoveButton.h"
#import "Utill.h"
//#import "Command.h"

@implementation MoveButton
@synthesize isSelected = _isSelected;
//@synthesize delegate = _delegate;

-(instancetype)init{
    self = [super init];

    if (self ) {

    }
    return self;
  }

//- (instancetype)initWithFrame:(CGRect)frame setStateImg:(NSString*)imgName setStateHighImg:(NSString*)imgHighName;//设置按钮的大小
- (instancetype)initWithFrame:(CGRect)frame setStateImg:(NSString*)imgName;//设置按钮的大小

{
    self = [super initWithFrame:frame];
    if (self) {
        _isSelected = NO;
        stateNormalImg = imgName;
//        stateHightImg = imgHighName;
        [self initButton:self.bounds];
        [self addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame setStateImg:(NSString*)imgName setStateHighImg:(NSString*)imgHighName;//设置按钮的大小

{
    self = [super initWithFrame:frame];
    if (self) {
        _isSelected = NO;
        stateNormalImg = imgName;
        stateHightImg = imgHighName;
        [self initButton:self.bounds];
        [self addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setImageForStateSelected:(NSString *)imageSelected{//设置选中后按钮图片
    
    stateSeletedImg = imageSelected;
}

-(void)setImageForStateHighted:(NSString *)imageHighted{//设置选中后按钮图片
    stateHightImg = imageHighted;

}
-(void)initButton:(CGRect)frame{//添加按钮控件

    self.forDisplayButton = [[UIButton alloc]initWithFrame:frame];
    self.forDisplayButton.userInteractionEnabled = NO;//设置button按钮是否响应事件。Yes为响应，no为不响应
    [self.forDisplayButton setImage:[UIImage imageNamed:stateNormalImg] forState:UIControlStateNormal];
    [self.forDisplayButton setImage:[UIImage imageNamed:stateHightImg] forState:UIControlStateHighlighted];
    [self addSubview:self.forDisplayButton];
    NSLog(@"aaaaa");
}

-(void)changeState{//点击同一个按钮时更换图片事件。

    NSLog(@"进入了MoveButton...类中的点击事件。");

    if (!_isSelected) { //当第二状态时的图片及位置设置
        [self.forDisplayButton setImage:[UIImage imageNamed:stateNormalImg  ] forState:UIControlStateNormal];
        [self.forDisplayButton.superview.superview.superview setFrame:KeyBoradNormalFrame ];
        [self.delegate moveButtonState:@""];
        NSLog(@"默认状态");
    }else{
        [self.forDisplayButton setImage:[UIImage imageNamed:stateSeletedImg] forState:UIControlStateNormal];
        [self.forDisplayButton.superview.superview.superview setFrame:KeyBoradSelectedFrame];
        NSLog(@"第二状态");
    }
//    [self.delegate testLog:self.forDisplayButton];
}


-(void)setNormalImage{

    [self.forDisplayButton setImage:[UIImage imageNamed:stateNormalImg ] forState:UIControlStateNormal];
}

-(void)setSelectedImage{
    
    [self.forDisplayButton setImage:[UIImage imageNamed:stateSeletedImg ] forState:UIControlStateNormal];
}

-(void)clickBtn:(id)sender{

    NSLog(@"xxx");
    if (_isSelected == YES) {
        _isSelected = NO;
    }else{
        _isSelected =YES;
    }
    [self changeState];
}

-(void)reNewBtn{   //外界调用此方法，可以还原按钮状态。

    if (_isSelected) {
        _isSelected = NO;
        [self changeState];
    }
}

@end
