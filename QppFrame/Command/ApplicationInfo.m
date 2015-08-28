//
//  ApplicationInfo.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/25.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "ApplicationInfo.h"

//static ApplicationInfo* applicationInfo = nil;

@implementation ApplicationInfo

static ApplicationInfo* applicationInfo = nil;

+(ApplicationInfo*)sharedApplicationInfo{
    
    @synchronized(self){
        if(applicationInfo == nil){
            applicationInfo = [[super allocWithZone:NULL]init];
        }
    }
    return applicationInfo;
}

+(id)allocWithZone:(struct _NSZone *)zone{

    return [self sharedApplicationInfo] ;
}

//-(void)setUserInfo:(UserInfo*) userInfoValue{
//
////    userInfo = userInfoValue;
//}
//
//-(UserInfo*)getUserInfo{
//
//    return userInfo;
//}


@end
