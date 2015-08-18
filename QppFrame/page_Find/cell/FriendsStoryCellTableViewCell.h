//
//  FriendsStoryCellTableViewCell.h
//  Example
//
//  Created by LingKangLi on 15/6/13.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsStoryCellTableViewCell : UITableViewCell

//类型1.（只有文字）
@property (weak, nonatomic) IBOutlet UIImageView *personImg;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UILabel *personInfo;
@property (weak, nonatomic) IBOutlet UILabel *infoDate;

//类型2.（）
@property (weak,nonatomic)IBOutlet UIImageView* imgView;
@property (weak,nonatomic)NSString* type;

//类型3.
@end
