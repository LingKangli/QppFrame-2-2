//
//  ChatEachWritingCell.m
//  QppFrame
//
//  Created by 孙兴国 on 15/7/16.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "ChatEachWritingCell.h"

@implementation ChatEachWritingCell

@synthesize writeContentLab;
@synthesize timeLab;
@synthesize perImg;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //        _contentText.textColor = [UIColor grayColor];
        //        _time.textColor = [UIColor grayColor];
//        writeContentLab.text = @"hello world.";
//        timeLab.text = @"12:00";
//        perImg.image = [UIImage imageNamed:@"1.jpg"];
        
    }
    return self;
}

@end
