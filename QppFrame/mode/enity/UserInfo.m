//
//  UserInfo.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/22.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "UserInfo.h"
static UserInfo* user = nil;
@implementation UserInfo

//@synthesize userID = _userID;
@synthesize userImg = _userImg;
@synthesize userName =_userName;
@synthesize userPwd = _userPwd;
@synthesize userEmail = _userEmail;
@synthesize userToken = _userToken;
@synthesize userYunID = _userYunID;
@synthesize userYunPwd = _userYunPwd;
@synthesize userYunAccountSid = _userYunAccountSid;
@synthesize userYunToken = _userYunToken;
@synthesize userYundateCreate = _userYundateCreate;

+(UserInfo*)sharedUserInfo{

    user = [[UserInfo alloc]init];
    if (user) {
        NSLog(@"the userInfo have.");
    }
    return user;
}

@end
