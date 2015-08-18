//
//  ImgObj.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/14.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "ImgObj.h"


@implementation ImgObj

@synthesize delegate = _delegate;

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initial:frame];
    }
    return self;
}
-(void)initial:(CGRect)frame{
    _recorderBtn = [[GifImageButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _recorderBtn.layer.borderWidth = 1.0;
    _recorderBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _recorderBtn.backgroundColor = [UIColor brownColor];
    //    [_recorderBtn setTitle:@"recorder" forState:UIControlStateNormal];
    
    [_recorderBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
//    [_recorderBtn addTarget:self action:@selector(btnUp:) forControlEvents:UIControlEventTouchUpInside];
//    [_recorderBtn addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchCancel];
//    [_recorderBtn addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchUpOutside];
    
    [self addSubview:_recorderBtn];
    
    //    timer = [NSTimer  timerWithTimeInterval:0 target:self selector:@selector(detectionVoice)userInfo:nil repeats:YES];
    

}
-(void)btnDown:(id)sender{
    
    [self.delegate sucessForPicPath:_imgNormalName];

}
-(void)setImgNormalName:(NSString *)imgNormalName{
    
    NSLog(@"test imgName is %@",imgNormalName);
    _imgNormalName = imgNormalName;
    
    if ([[[UtilBiaoQingData shareUtil] getBiaoQingType:imgNormalName] isEqualToString:BQPNG]) {
        [_recorderBtn setImage:[UIImage imageNamed:imgNormalName] forState:UIControlStateNormal];
    }
    else if ([[[UtilBiaoQingData shareUtil] getBiaoQingType:imgNormalName] isEqualToString:BQGIF]) {
        [_recorderBtn setImageForPath:[[NSBundle mainBundle]pathForResource:[imgNormalName stringByReplacingOccurrencesOfString:@".gif" withString:@""] ofType:@"gif" ]];
        
        
    }
}


@end
