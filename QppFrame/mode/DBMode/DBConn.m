//
//  DBConn.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/22.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "DBConn.h"

static DBConn* dbConn = nil;

@implementation DBConn
@synthesize db;

+(DBConn*)sharedDBConn{

//    NSString* database_path = @"Qpp.sqlite";
//    FMDatabase* db = [FMDatabase databaseWithPath:database_path];
    dbConn = [[self alloc]init];
    if (self) {
        
    }
    return dbConn;
}

-(BOOL)openDB{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];

//    NSString* docDir = NSHomeDirectory();
//    NSString* database_path = [docDir stringByAppendingString:@"/Qpp.sqlite"];
    NSString* database_path =  [[NSBundle mainBundle] pathForResource:@"Qpp" ofType:@"sqlite"];
//    NSString* database_path = @"Qpp.sqlite";
    
    NSLog(@"database_path : %@",database_path);
    
    db = [FMDatabase databaseWithPath:database_path];
    if ([ db open]) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)closeDB{//关闭数据库
    if ([db open]) {
        return YES;
    }else{
        return NO;
    }
}

@end
