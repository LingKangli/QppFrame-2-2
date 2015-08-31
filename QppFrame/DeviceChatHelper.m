//
//  DeviceChatHelper.m
//  ECSDKDemo_OC
//
//  Created by jiazy on 14/12/15.
//  Copyright (c) 2014年 ronglian. All rights reserved.
//

#import "DeviceChatHelper.h"
#import "ChatViewController.h"
#import "ZipArchive.h"

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
-(ECMessage*)sendimageMessage:(NSString*)file displayName:(NSString *)displayname to:(NSString*)to
{
    ECImageMessageBody *messageBody = [[ECImageMessageBody alloc] initWithFile:file displayName:displayname];
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
            NSLog(@"发送失败");
        }
    }];
    
    return message;

}
-(ECMessage *)sendFileMessage:(NSString *)file displayname:(NSString *)displayname to:(NSString *)to
{
    ECFileMessageBody *messageBody = [[ECFileMessageBody alloc] initWithFile:file displayName:displayname];
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
            NSFileManager *fileManager = [[NSFileManager alloc]init];
            [fileManager removeItemAtPath:file error:nil];
            
        }else if(error.errorCode == ECErrorType_Have_Forbid || error.errorCode == ECErrorType_File_Have_Forbid)
        {
            //您已被群组禁言
        }else{
            //发送失败
            NSLog(@"发送失败");
        }
    }];
    
    return message;
    
    
}
-(void)downloadMediaMessage:(ECMessage*)message andCompletion:(void(^)(ECError *error, ECMessage* message))completion{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    ECFileMessageBody *mediaBody = (ECFileMessageBody*)message.messageBody;
    
    mediaBody.localPath = [path stringByAppendingPathComponent:mediaBody.displayName];
    NSLog(@"%@",mediaBody.localPath);
    [[ECDevice sharedInstance].messageManager downloadMediaMessage:message progress:self completion:^(ECError *error, ECMessage *message) {
        if (error.errorCode == ECErrorType_NoError) {
            NSLog(@"下载成功%@",mediaBody.localPath);
            
            
           
              
                
                ZipArchive *za = [[ZipArchive alloc]init];
            
                if ([za UnzipOpenFile:mediaBody.localPath]) {
                    BOOL ret = [za UnzipFileTo:path overWrite:YES];
                    if (NO== ret){[za UnzipCloseFile];}
                    
                    NSString *imagePath;
                    NSString *voicePath;
                    for (NSString *str in za.filePath) {
                        if ([str rangeOfString:@".gif"].location != NSNotFound) {
                            imagePath = str;
                        }
                        if ([str rangeOfString:@".aac"].location != NSNotFound) {
                            voicePath = str;
                        }
                        
                    }
                    
                    
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_DownloadFileCompletion object:nil userInfo:@{@"image":imagePath,@"voice":voicePath}];
                  
                  
                    
                  
              }
                
            

        
        }
      
      
        
    }];

}



@end
