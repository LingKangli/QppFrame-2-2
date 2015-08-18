//
//  ServerConnect.m
//  QppFrame
//
//  Created by LingKangLi on 15/7/10.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "ServerConnect.h"
#import "JSONKit.h"
#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>

#pragma setProperty  =====

#define kGlobalQueue    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)

@implementation ServerConnect

static ServerConnect *shareServerConnect = nil;
+ (ServerConnect *)sharedManager{
    @synchronized (self){//为了确保多线程情况下，仍然确保实体的唯一性
        if (!shareServerConnect) {
            shareServerConnect = [[self alloc] init];//非ARC模式下,该方法会调用 allocWithZone
        }
        return shareServerConnect;
    }
}

-(instancetype)init{
    
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}

//注册方法。
-(NSDictionary*)resignToName:(NSString*)userName ToPwd :(NSString*)pwd{
    
    //    self
    // 1.设置请求路径
       NSURL *URL=[NSURL URLWithString:serverHTTP];//不需要传递参数
    
     //    2.创建请求对象
         NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
       request.timeoutInterval=5.0;//设置请求超时为5秒
       request.HTTPMethod=@"POST";//设置请求方法
   
        //设置请求体
         NSString *param=[NSString stringWithFormat:@"email=%@&password=%@",userName,pwd];
        //把拼接后的字符串转换为data，设置请求体
        request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    //    3.发送请求
    NSURLConnection* theConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (theConnection) {
        
        NSLog(@"Connection successed.");
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString* dataString = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        NSError* error ;
//        NSDictionary *serverResignInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        NSDictionary *serverResignInfoDic = [dataString objectFromJSONString];
        NSLog(@"json1.a:%@",[serverResignInfoDic objectForKey:@"data"]);
        NSLog(@"json1.b:%@",[serverResignInfoDic objectForKey:@"result"]);
        
//        因为返回的Json文件有两层，去第二层内容放到字典中去
        NSLog(@"json:%@",serverResignInfoDic);
        return serverResignInfoDic;
        
    }else{
        NSLog(@"Connection failed.");
        
        return nil;
    }
}

-(NSDictionary*)loginOfName:(NSString*)userName ToPwd: (NSString*)pwd{
    
    //    self
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:serverLogin];//不需要传递参数
    
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
//    NSString* device =
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
//    NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    NSLog(@"identifierForVendor%@",identifierForVendor);
//    NSLog(@"identifierForAdvertising%@",identifierForAdvertising);
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"email=%@&password=%@&device=%@",userName,pwd,identifierForVendor];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    //    3.发送请求
    NSURLConnection* theConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (theConnection) {
        
        NSLog(@"Connection successed.");
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString* dataString = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];

//        NSError* error ;
        NSDictionary *serverResignInfoDic = [dataString objectFromJSONString];
        NSLog(@"test serverResignInfoDic %@:",serverResignInfoDic);
     
        return serverResignInfoDic;
        
    }else{
        NSLog(@"Connection failed.");
        return nil;
    }
}

@end
