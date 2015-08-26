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
@property(nonatomic)NSInteger userID;
@property(nonatomic)NSString* userPwd;
@property(nonatomic)NSString* userEmail;

+(UserInfo*)sharedUserInfo;
@end
