//
//  PicViewItem.m
//  KeyBorad
//
//  Created by Ling Kangli on 15/7/13.
//  Copyright (c) 2015年 fengdu. All rights reserved.
//

#import "PicViewItem.h"

@implementation PicViewItem
@synthesize itemLab;
@synthesize itemView;



-(instancetype)init{

    self = [super init];
    if (self) {

        itemView = [[UIImageView alloc]init];
        itemLab = [[UILabel alloc]init];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
//    self.backgroundColor = [UIColor redColor];
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1.0;
    if (self) {

        itemView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        itemView.backgroundColor = [UIColor whiteColor];
        [self addSubview:itemView];
        
        itemLab = [[UILabel alloc]initWithFrame:CGRectMake(0,itemView.frame.origin.y+itemView.frame.size.height,frame.size.width,frame.size.height-40 )];
        itemLab.textAlignment  =  NSTextAlignmentCenter;
//        itemLab.backgroundColor = [UIColor blackColor];
        [self addSubview:itemLab];
        
    }
    return self;
}


@end
