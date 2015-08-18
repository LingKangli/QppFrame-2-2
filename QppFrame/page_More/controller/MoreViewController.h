//
//  MoreViewController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface MoreViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray* moreList;
}
@property (strong,nonatomic)UITableView* tableView;


@end
