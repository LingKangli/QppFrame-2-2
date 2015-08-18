//
//  PersonCenter.h
//  Example
//
//  Created by LingKangLi on 15/6/12.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCenterView : UIView<UITableViewDataSource,UITableViewDelegate>{

    NSArray* sectionOne;
    NSArray* sectionTwo;
}

@property (nonatomic,strong) UITableView* tableView;
@end
