//
//  TongXuLvCell.m
//  Example
//
//  Created by LingKangLi on 15/6/10.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "TongXuLvCell.h"

@implementation TongXuLvCell

@synthesize friendName = _friendName;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self) {
        //Initialization code
        _friendName.textColor = [UIColor redColor];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
