//
//  DBConn.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/22.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConn.h"
#import "FMDatabase.h"

@interface DBConn : NSObject{
//    FMDatabase* db;
}

@property(nonatomic)FMDatabase* db;

+(DBConn*)sharedDBConn;

-(BOOL)openDB;//打开数据库
-(BOOL)closeDB;//关闭数据库

@end
