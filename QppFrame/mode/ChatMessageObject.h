//
//  ChatMessageObject.h
//  QppFrame
//
//  Created by 孙兴国 on 15/7/16.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChatWritingObject.h"
#import "ChatVoiceObject.h"
#import "ChatPicObject.h"

@interface ChatMessageObject : NSObject

@property (nonatomic) ChatWritingObject* writingObj;
@property (nonatomic) ChatVoiceObject* voiceObj;
@property (nonatomic) ChatPicObject* picObj;

@end
