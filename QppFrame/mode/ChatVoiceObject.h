//
//  ChatVoiceObject.h
//  QppFrame
//
//  Created by 孙兴国 on 15/7/16.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatObject.h"

@interface ChatVoiceObject : ChatObject

//输入语音
@property(nonatomic,strong) NSString* soundName;
@property(nonatomic,strong) NSString* soundType;
@property(nonatomic,strong) NSString* soundPath;
@property(nonatomic,strong) NSString* soundImg;

@end
