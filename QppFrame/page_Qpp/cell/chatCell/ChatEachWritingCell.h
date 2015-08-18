//
//  ChatEachWritingCell.h
//  QppFrame
//
//  Created by 孙兴国 on 15/7/16.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageObject.h"

@interface ChatEachWritingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *perImg;
@property (weak, nonatomic) IBOutlet UILabel *writeContentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
