//
//  ChatObject.h
//  QppFrame
//
//  Created by 孙兴国 on 15/7/16.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    talkWrite = 0, //文字
    talkVoice, //声音
    talkPic  //图片
}TalkType;

@interface ChatObject : NSObject

@property(nonatomic) TalkType type;
@property(nonatomic,strong) NSString* time;

@end
