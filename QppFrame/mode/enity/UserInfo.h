//
//  UserInfo.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/22.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(nonatomic)NSString* userImg;
@property(nonatomic)NSString* userName;
@property(nonatomic)NSString* userPwd;
@property(nonatomic)NSString* userEmail;
@property(nonatomic)NSString* userToken;
@property(nonatomic)NSString* userYunID;
@property(nonatomic)NSString* userYunPwd;
@property(nonatomic)NSString* userYunAccountSid;
@property(nonatomic)NSString* userYunToken;
@property(nonatomic)NSString* userYundateCreate;

//@property(nonatomic)NSString* 
+(UserInfo*)sharedUserInfo;

@end
