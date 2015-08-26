//
//  DeviceChatHelper.m
//  ECSDKDemo_OC
//
//  Created by jiazy on 14/12/15.
//  Copyright (c) 2014年 ronglian. All rights reserved.
//

#import "DeviceChatHelper.h"
#import "ChatViewController.h"

@implementation DeviceChatHelper
{
    SystemSoundID sendSound;
}

+(DeviceChatHelper*)sharedInstance{
    static dispatch_once_t DeviceChatHelperOnce;
    static DeviceChatHelper *deviceChatHelper;
    dispatch_once(&DeviceChatHelperOnce, ^{
        deviceChatHelper = [[DeviceChatHelper alloc] init];
    });
    return deviceChatHelper;
}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}


-(void)playSendMsgSound{
    
            //播放声音
        AudioServicesPlaySystemSound(sendSound);
    
}

/**
 @brief 设置进度
 @discussion 用户需实现此接口用以支持进度显示
 @param progress 值域为0到1.0的浮点数
 @param message  某一条消息的progress
 @result
 */
- (void)setProgress:(float)progress forMessage:(ECMessage *)message{
    NSLog(@"DeviceChatHelper setprogress %f,messageId=%@,from=%@,to=%@,session=%@",progress,message.messageId,message.from,message.to,message.sessionId);
}

-(ECMessage*)sendTextMessage:(NSString*)text to:(NSString*)to{
    
    
    
    ECTextMessageBody *messageBody = [[ECTextMessageBody alloc] initWithText:text];
    ECMessage *message = [[ECMessage alloc] initWithReceiver:to body:messageBody];
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval tmp =[date timeIntervalSince1970]*1000;
    
#warning 入库前设置本地时间，以本地时间排序和以本地时间戳获取本地数据库缓存数据
    message.timestamp = [NSString stringWithFormat:@"%lld", (long long)tmp];

    
    [[ECDevice sharedInstance].messageManager sendMessage:message progress:nil completion:^(ECError *error,
                                                                                            ECMessage *amessage) {
        
        if (error.errorCode == ECErrorType_NoError) {
            //发送成功
            NSLog(@"发送成功");
        }else if(error.errorCode == ECErrorType_Have_Forbid || error.errorCode == ECErrorType_File_Have_Forbid)
        {
            //您已被群组禁言
        }else{
            //发送失败
        }
    }];

    return message;
}

-(ECMessage*)sendMediaMessage:(ECFileMessageBody*)mediaBody to:(NSString*)to isMcm:(BOOL)ismcm{
    
    ECMessage *message = [[ECMessage alloc] initWithReceiver:to body:mediaBody];
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval tmp =[date timeIntervalSince1970]*1000;
    
#warning 入库前设置本地时间，以本地时间排序和以本地时间戳获取本地数据库缓存数据
    message.timestamp = [NSString stringWithFormat:@"%lld", (long long)tmp];
    
    if (ismcm) {
        [[ECDevice sharedInstance].messageManager sendToDeskMessage:message progress:self completion:^(ECError *error, ECMessage *amessage) {
            
            if (error.errorCode == ECErrorType_NoError) {
                [self playSendMsgSound];
            } else if(error.errorCode == ECErrorType_Have_Forbid || error.errorCode == ECErrorType_File_Have_Forbid) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已被禁言" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            } else if (error.errorCode == ECErrorType_ContentTooLong) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.errorDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
           
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_SendMessageCompletion object:nil userInfo:@{KErrorKey:error, KMessageKey:amessage}];
        }];
    }else{
        [[ECDevice sharedInstance].messageManager sendMessage:message progress:self completion:^(ECError *error, ECMessage *amessage) {
            
            if (error.errorCode == ECErrorType_NoError) {
                [self playSendMsgSound];
            } else if (error.errorCode == ECErrorType_Have_Forbid || error.errorCode == ECErrorType_File_Have_Forbid) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已被禁言" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            } else if (error.errorCode == ECErrorType_ContentTooLong) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.errorDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_SendMessageCompletion object:nil userInfo:@{KErrorKey:error, KMessageKey:amessage}];
        }];
    }
    
    NSLog(@"DeviceChatHelper sendMediaMessage messageid=%@",message.messageId);
    
    
    
    return message;
}

-(void)downloadMediaMessage:(ECMessage*)message andCompletion:(void(^)(ECError *error, ECMessage* message))completion{
    
    ECFileMessageBody *mediaBody = (ECFileMessageBody*)message.messageBody;
    mediaBody.localPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:mediaBody.displayName];
        
    [[ECDevice sharedInstance].messageManager downloadMediaMessage:message progress:self completion:^(ECError *error, ECMessage *message) {
        if (error.errorCode == ECErrorType_NoError) {
            
        } else {
                   }
        
        if (completion != nil) {
            completion(error, message);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_DownloadMessageCompletion object:nil userInfo:@{KErrorKey:error, KMessageKey:message}];

    }];
}

-(ECMessage*)resendMessage:(ECMessage*)message isMcm:(BOOL)ismcm{
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval tmp =[date timeIntervalSince1970]*1000;
    
    if (message.messageBody.messageBodyType == MessageBodyType_Text) {
        ECTextMessageBody *messageBody = (ECTextMessageBody *)message.messageBody;
        messageBody.text = [ChatViewController sharedInstance].keyBorad.sendMessageField.text;
    }
#warning 入库前设置本地时间，以本地时间排序和以本地时间戳获取本地数据库缓存数据
    message.timestamp = [NSString stringWithFormat:@"%lld", (long long)tmp];
    
    NSString *oldMsgId = message.messageId;
    if (ismcm) {
        message.messageId = [[ECDevice sharedInstance].messageManager sendToDeskMessage:message progress:self completion:^(ECError *error, ECMessage *amessage) {
            
            if (error.errorCode == ECErrorType_NoError) {
                [self playSendMsgSound];
            } else if (error.errorCode == ECErrorType_Have_Forbid || error.errorCode == ECErrorType_File_Have_Forbid) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已被禁言" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            } else if (error.errorCode == ECErrorType_ContentTooLong) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.errorDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_SendMessageCompletion object:nil userInfo:@{KErrorKey:error, KMessageKey:amessage}];
        }];
    } else {
        message.messageId = [[ECDevice sharedInstance].messageManager sendMessage:message progress:self completion:^(ECError *error, ECMessage *amessage) {
            
            if (error.errorCode == ECErrorType_NoError) {
                [self playSendMsgSound];
            } else if (error.errorCode == ECErrorType_Have_Forbid || error.errorCode == ECErrorType_File_Have_Forbid) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已被禁言" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            } else if (error.errorCode == ECErrorType_ContentTooLong) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.errorDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_SendMessageCompletion object:nil userInfo:@{KErrorKey:error, KMessageKey:amessage}];
        }];
    }
    
    //更新消息id
    

    return nil;
}
@end
