//
//  UserInfoDAO.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/22.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "AsFrindInfo.h"

@interface UserInfoDAO : NSObject

-(UserInfo*)getCurrentUserInfo;

-(NSMutableArray*) getUserFriends;//得到当前用户的所有朋友名字


@end
