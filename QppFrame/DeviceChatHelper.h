//
//  DeviceChatHelper.h
//  ECSDKDemo_OC
//
//  Created by jiazy on 14/12/15.
//  Copyright (c) 2014年 ronglian. All rights reserved.
//
#define KNOTIFICATION_DownloadFileCompletion   @"KNOTIFICATION_DownloadFileCompletion"



#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import "ECDeviceHeaders.h"
#import "ECFileMessageBody.h"






@interface DeviceChatHelper : NSObject<ECProgressDelegate>


+(DeviceChatHelper*)sharedInstance;

-(ECMessage*)sendTextMessage:(NSString*)text to:(NSString*)to;
-(ECMessage*)sendimageMessage:(NSString*)file displayName:(NSString *)displayname to:(NSString*)to;
-(ECMessage *)sendFileMessage:(NSString *)file displayname:(NSString *)displayname to:(NSString *)to;
-(void)downloadMediaMessage:(ECMessage*)message andCompletion:(void(^)(ECError *error, ECMessage* message))completion;
@end
