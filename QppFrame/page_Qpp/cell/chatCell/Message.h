//
//  Message.h
//
//
//  Created by ling Kangli on 15-8-3.
//  Copyright (c) 2015年 Fengdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Utill.h"
#import "MultChatObj.h"

typedef enum {
    
    MessageTypeMe = 0, // 自己发的
    MessageTypeOther = 1 //别人发得
    
} MessageType;


typedef enum {
    
    MessageShowTypeText = 0, // 文字
    MessageShowTypeImg = 1 ,//图片
    MessageShowTypeImgVoice = 2, //图片声音
    MessageShowTypeData = 3,
    MessageShowTypeImgVoiceByUIIMG = 4,
    MessageShowTypeMultChatImg = 5,
    MessageShowTypeImageAndVoice = 6,
} MessageShowType;


@interface Message : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) MessageType type;
@property (nonatomic,assign)MessageShowType showType;
@property (nonatomic,strong) NSString* voiceImgName;
@property (nonatomic,strong)NSURL* voicePath;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic,assign)DataType dataType;
@property(nonatomic,strong)NSDate* imageData;
@property(nonatomic,strong)NSDate* voiceData;

@property(nonatomic,strong)UIImage* image;

@property(nonatomic)BOOL isCurrentSend;//连网测试

@property(nonatomic)MultChatObj* mCObj;//多语音时用到。

@end
