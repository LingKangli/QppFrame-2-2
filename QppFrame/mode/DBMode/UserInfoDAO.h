//
//  UserInfoDAO.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/22.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserInfoDAO : NSObject

-(UserInfo*)getCurrentUserInfo;
@end
