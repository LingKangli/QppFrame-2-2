//
//  MultChatPlayer.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "MultChatPlayer.h"

@implementation MultChatPlayer

@synthesize playerImg;
@synthesize playUrl = _playUrl;
@synthesize point = _point;
@synthesize centerPoint = _centerPoint;

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        _playerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_playerImg];
        [self addTarget:self action:@selector(dragMoving:withEvent: )forControlEvents: UIControlEventTouchDragInside];
        [self addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) dragMoving: (UIControl *) c withEvent:ev
{
    CGPoint point = [[[ev allTouches]anyObject] locationInView:self.window];
    self.center = CGPointMake(point.x+self.superview.frame.origin.x, point.y-self.superview.frame.origin.y);
}
-(void)setPlayerImg:(UIImage *)playerImg{

    _playerImg.image = playerImg;
}
-(void)clickBtn{

    player = [UUAVAudioPlayer sharedInstance];
    [player playSongWithUrl:_playUrl];
    [self.delegate multChatPlayerMove:_centerPoint OfTag:self.tag];

    NSLog(@"clickBtn is ok%@",self.playUrl);
}

@end
