//
//  Util.m
//  TestScrollViewIndex
//
//  Created by Ling Kangli on 15/8/6.
//  Copyright (c) 2015年 fengDu. All rights reserved.
//

#import "UtilBiaoQingData.h"
#import "Utill.h"

@implementation UtilBiaoQingData

+(UtilBiaoQingData*)shareUtil{

    static UtilBiaoQingData *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];

       
    });
    
    return sharedAccountManagerInstance;
}

-(NSArray*)getBiaoQingIndexName:(NSString*)bQTypeName{
    //读取plist
    NSBundle *bundle = [NSBundle mainBundle];
    
    // 设置资源文件名称为Property List,资源类型为plist
    NSString *path = [bundle pathForResource:@"biaoQinInfo"ofType:@"plist"];
    NSLog(@"path is %@",path);
    
    // 在plist中配置了一个NSDictionary字典,字典key为StateCapital
    NSMutableArray *dictArray = [[[NSDictionary alloc]initWithContentsOfFile:path] objectForKey:@"biaoQing"];
    NSLog(@"dic is %@",dictArray);
    
    for (int i = 0; i < dictArray.count; i++) {
        NSDictionary *dict = dictArray[i];
        NSString* name = [dict objectForKey:@"biaoQingName"];
        NSArray* contentAry = [dict objectForKey:@"biaoQingContent"];
        NSLog(@"dict is %@",dict);
        NSLog(@"name is %@",name);
        NSLog(@"contentAry is %@",contentAry);
        
        if ([name isEqualToString:bQTypeName]) {
            return contentAry;
        }
    }
    
    return dictArray;
}

-(NSMutableArray*)getBiaoQingIndex:(NSInteger)bQIndex{

    //读取plist
    NSBundle *bundle = [NSBundle mainBundle];
    
    // 设置资源文件名称为Property List,资源类型为plist
    NSString *path = [bundle pathForResource:@"biaoQinInfo"ofType:@"plist"];
    NSLog(@"path is %@",path);
    
    // 在plist中配置了一个NSDictionary字典,字典key为StateCapital
    NSMutableArray *dictArray = [[[NSDictionary alloc]initWithContentsOfFile:path] objectForKey:@"biaoQing"];
    NSLog(@"dic is %@",dictArray);
    
        NSDictionary *dict = dictArray[bQIndex];
        NSString* name = [dict objectForKey:@"biaoQingName"];
        NSMutableArray* contentAry = [dict objectForKey:@"biaoQingContent"];
        NSLog(@"dict is %@",dict);
        NSLog(@"name is %@",name);
        NSLog(@"contentAry is %@",contentAry);

    return contentAry;
}


-(NSUInteger)getBiaoQingTypeNum{
    //读取plist
    NSBundle *bundle = [NSBundle mainBundle];
    
    // 设置资源文件名称为Property List,资源类型为plist
    NSString *path = [bundle pathForResource:@"biaoQinInfo"ofType:@"plist"];
    NSLog(@"path is %@",path);
    
    // 在plist中配置了一个NSDictionary字典,字典key为StateCapital
    NSMutableArray *dictArray = [[[NSDictionary alloc]initWithContentsOfFile:path] objectForKey:@"biaoQing"];
    NSLog(@"dic is %@",dictArray);

    return dictArray.count;
}

-(NSMutableArray*)getBiaoQingTypeArray{
    //读取plist
    NSBundle *bundle = [NSBundle mainBundle];
    
    // 设置资源文件名称为Property List,资源类型为plist
    NSString *path = [bundle pathForResource:@"biaoQinInfo"ofType:@"plist"];
    NSLog(@"path is %@",path);
    
    // 在plist中配置了一个NSDictionary字典,字典key为StateCapital
    NSMutableArray *dictArray = [[[NSDictionary alloc]initWithContentsOfFile:path] objectForKey:@"biaoQing"];
    NSLog(@"dic is %@",dictArray);
    
    NSMutableArray* getTypeArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [dictArray count]; i++) {
        NSDictionary *dict = dictArray[i];
        NSString* name = [dict objectForKey:@"biaoQingName"];
        NSArray* contentAry = [dict objectForKey:@"biaoQingContent"];
        NSLog(@"dict is %@",dict);
        NSLog(@"name is %@",name);
        NSLog(@"contentAry is %@",contentAry);
        
        [getTypeArray addObject:name];
       
    }
 
    
    return getTypeArray;
//    return <#expression#>
}

-(NSString*)getBiaoQingType:(NSString*)biaoQingName{
    
    
//    NSString *temp = @"english, french, japanese, chinese";
//    NSString *jap = @"japanese";
    NSRange foundObj=[biaoQingName rangeOfString:@".png" options:NSCaseInsensitiveSearch];
    if(foundObj.length>0) {
        NSLog(@"the test is png");
        return BQPNG;
    } else {
        NSLog(@"the test is GIF");
        return BQGIF;
    }
    
    
    /*
    NSLog(@"the png image %@ is %i",biaoQingName, [biaoQingName rangeOfString:@".png"].length);

    if ([biaoQingName rangeOfString:@".png"].length == 1) {

        NSLog(@"the png image %@ is %i",biaoQingName, [biaoQingName rangeOfString:@".png"].length);
        return BQPNG;
    } ;
    if ([biaoQingName rangeOfString:@".gif"].length == 1) {
        NSLog(@"the gif image %@ is %i",biaoQingName, [biaoQingName rangeOfString:@".png"].length);

        return BQGIF;
    } ;

    return nil;
     */
}

@end
