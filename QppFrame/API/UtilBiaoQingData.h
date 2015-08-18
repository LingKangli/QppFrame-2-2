//
//  Util.h
//  TestScrollViewIndex
//
//  Created by Ling Kangli on 15/8/6.
//  Copyright (c) 2015年 fengDu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UtilBiaoQingData : NSObject

+(UtilBiaoQingData*)shareUtil;

//@property (strong,nonatomic)NSMutableArray* biaoQingTypeArray;
@property (strong,nonatomic)NSMutableArray* biaoQingIndexArray;

-(NSMutableArray*)getBiaoQingTypeArray;
-(NSArray*)getBiaoQingIndexName:(NSString*)bQTypeName;//通过表情系列的名字，搜其下的所有表情
-(NSArray*)getBiaoQingIndex:(NSInteger)bQIndex;//通过显示第几个表情系列，搜到其下的所有表情。
-(NSUInteger)getBiaoQingTypeNum;//得到有几个表情系列

-(NSString*)getBiaoQingType:(NSString*)biaoQingName;
@end