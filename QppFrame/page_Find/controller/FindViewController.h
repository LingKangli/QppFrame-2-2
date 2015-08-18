//
//  FindViewController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface FindViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray* findContent;
    NSArray* imgArray;
}

@property (strong,nonatomic)UITableView* tableView;



@end
