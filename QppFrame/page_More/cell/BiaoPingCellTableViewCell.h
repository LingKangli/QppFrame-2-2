//
//  BiaoPingCellTableViewCell.h
//  Example
//
//  Created by LingKangLi on 15/6/13.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiaoPingCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BiaoPingImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *explainLab;
@property (weak, nonatomic) IBOutlet UIButton *isDown;

@end
