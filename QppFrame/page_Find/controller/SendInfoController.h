//
//  SendInfoController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface SendInfoController :BaseUIViewController<UITableViewDataSource,UITableViewDelegate>{

    NSArray* limitsList;
}

@property (nonatomic,strong)UITableView* limitsList;

@end
