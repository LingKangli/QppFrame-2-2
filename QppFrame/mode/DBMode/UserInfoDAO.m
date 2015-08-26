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

}

-(NSMutableArray*) getUserFriends{

    NSMutableArray* userFrieds = [[NSMutableArray alloc]init];
    
    DBConn* dbConn = [DBConn sharedDBConn];
    
    if ([dbConn openDB]) {/*
        NSString * sql = [NSString stringWithFormat:
                          @"select distinct friendsListTabel.friendID,userInfo_table.userName,userInfo_table.userEmail, userInfo_table.Ssex from friendsListTabel,userInfo_table\
                          where userInfo_table.userID=friendsListTabel.friendID\
                          and friendsListTabel.userID =1"];*/
        
        NSString * sql = [NSString stringWithFormat:
                          @"select distinct userInfo_table.userName from friendsListTabel,userInfo_table\
                          where userInfo_table.userID=friendsListTabel.friendID\
                          and friendsListTabel.userID =1"];

        FMResultSet * rs = [dbConn.db executeQuery:sql];
        while ([rs next]) {/*
            AsFrindInfo* userInfo = [[AsFrindInfo alloc]init];
            userInfo.userName = [rs stringForColumn:@"userName"];
            userInfo.userEmail = [rs stringForColumn:@"userEmail"];
            userInfo.Ssex = [rs stringForColumn:@"Ssex"];
            NSLog(@"userInfo friends is %@",userInfo.userName);
            [userFrieds addObject:userInfo];*/
            NSString* userName = [rs stringForColumn:@"userName"];
            [userFrieds addObject:userName];
        }
//        NSArray *newArray = [userFrieds sortedArrayUsingSelector:@selector(compare:)];
//        NSLog(@"newarry :%@",newArray);
        
        [dbConn.db close];
    }
    
    return userFrieds;
}

//-(NSArray*)compare:(NSArray*)str {
//    return str;
//}
@end
