//
//  MultChatPlayer.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UUAVAudioPlayer.h"

@protocol multchatPlayerMovedDelegate <NSObject>

-(void)multChatPlayerMove:(CGPoint) centerP OfTag:(NSInteger) tag;

@end

@interface MultChatPlayer : UIButton<AVAudioRecorderDelegate,AVAudioPlayerDelegate>{
    UIImageView* _playerImg;
    NSURL* _playUrl;
    CGPoint _point;
    
    UUAVAudioPlayer* player;
    
}

@property (nonatomic) UIImage* playerImg;
@property (nonatomic) NSURL* playUrl;
@property (nonatomic) CGPoint point;
@property(nonatomic)CGPoint centerPoint;
@property(nonatomic)id<multchatPlayerMovedDelegate> delegate;

@end
