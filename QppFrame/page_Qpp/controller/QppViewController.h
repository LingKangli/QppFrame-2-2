//
//  QppViewController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"
#import "BaseUIViewController.h"


#import <AVFoundation/AVFoundation.h>

@interface QppViewController : BaseUIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    NSArray* imageNames;
    NSArray* namesText;
    NSArray* dataArray;
    NSArray* contentArray;
    
    BOOL isAdd;
    
    UISearchBar* search;
    PopView* popView;
    
}

@property (strong,nonatomic)UITableView* tableView;



@end
