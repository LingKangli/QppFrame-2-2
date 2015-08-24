//
//  Message.m
//
//
//  Created by ling Kangli on 15-8-3.
//  Copyright (c) 2015年 Fengdu. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize imageData;
@synthesize voiceData;
@synthesize image;
@synthesize mCObj;
@synthesize isCurrentSend;//连网测试

- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    self.icon = dict[@"icon"];
    self.time = dict[@"time"];
    self.content = dict[@"content"];
    self.type = [dict[@"type"] intValue];
    self.showType = [dict[@"msgType"] intValue];
    self.voiceImgName = dict[@"voiceImgName"];
}




@end
