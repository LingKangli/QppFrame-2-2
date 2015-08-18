//
//  MessageCell.h
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UUAVAudioPlayer.h"

@protocol playerDelegate <NSObject>

-(void)playTheVoice:(NSURL*)url;

@end


@class MessageFrame;

@interface MessageCell : UITableViewCell<UUAVAudioPlayerDelegate>
{
    UUAVAudioPlayer *audio;
    BOOL contentVoiceIsPlaying;

}
@property (nonatomic, strong) MessageFrame *messageFrame;
@property(nonatomic,strong) id<playerDelegate> delegate;
@end
