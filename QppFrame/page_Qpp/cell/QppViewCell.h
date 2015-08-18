//
//  TableViewCell.h
//  Example
//
//  Created by LingKangLi on 15/6/9.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QppViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *personImg;
@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *contentText;
@property (weak, nonatomic) IBOutlet UILabel *time;



@end
