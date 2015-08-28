//
//  ApplicationInfo.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/25.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfo.h"


@interface ApplicationInfo : NSObject{

//    UserInfo* userInfo;
}

//密码模式
@property(nonatomic)NSString* appkey ;
@property(nonatomic)NSString* userName;
@property(nonatomic)NSString* userPwd;

//默认模式
@property(nonatomic)NSString* appToken;

+(ApplicationInfo*)sharedApplicationInfo;
-(void)setUserInfo:(UserInfo*) userInfoValue;
-(UserInfo*)getUserInfo;
@end
