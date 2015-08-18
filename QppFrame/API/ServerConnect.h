//
//  ServerConnect.h
//  QppFrame
//
//  Created by LingKangLi on 15/7/10.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
//
typedef enum{
    sucess=0, //注册成功
    somenull=1,  //传入参数为空
    emailFontError = 2, //Email格式错误! 3->!
    pwdLengthError = 3, //密码长度错误（6~30）
    haveDoneError = 4  //4->Email已经被注册
}GetServerInfo;


#define serverHTTP @"http://qpp.fengdukeji.com/api/register"
#define serverLogin @"http://qpp.fengdukeji.com/api/login"

@interface ServerConnect :  NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    
}

+ (ServerConnect *)sharedManager;
//+(void)connection;
//+(NSData*)getServerData;
//-(void)postDataToServer:(NSDictionary*)data;

-(NSDictionary*)resignToName:(NSString*)userName ToPwd :(NSString*)pwd;
-(NSDictionary*)loginOfName:(NSString*)userName ToPwd: (NSString*)pwd;

@end
