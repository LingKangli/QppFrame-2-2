//
//  UserInfoDAO.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/22.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "UserInfoDAO.h"
#import "DBConn.h"
#import "TableData.h"

#define TABLENAME @"userInfo_table"

@implementation UserInfoDAO

-(UserInfo*)getCurrentUserInfo{

    DBConn* dbConn = [DBConn sharedDBConn];
    
    if ([dbConn openDB]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",TABLENAME];
        FMResultSet * rs = [dbConn.db executeQuery:sql];
        while ([rs next]) {
            int Id = [rs intForColumn:userInfo_table_userID];
            NSString * name = [rs stringForColumn:userInfo_table_userName];
            NSString * pwd = [rs stringForColumn:userInfo_table_userPWD];
            NSString * Email = [rs stringForColumn:userInfo_table_Email];
            NSString * ssex = [rs stringForColumn:userInfo_table_SSex];
            NSLog(@"id = %d, name = %@, pwd = %@ , Email = %@ ,ssex = %@", Id, name, pwd, Email,ssex);
        }
        [dbConn.db close];
    }
    return nil;
//if ([[DBConn sharedDBConn] openDB]) {
//}
}
@end
