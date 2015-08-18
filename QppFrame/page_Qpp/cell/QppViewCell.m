//
//  TableViewCell.m
//  Example
//
//  Created by LingKangLi on 15/6/9.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "QppViewCell.h"
#import "Utill.h"
@implementation QppViewCell

@synthesize personImg = _personImg ;
@synthesize nameText = _nameText;
@synthesize time = _time;
@synthesize contentText = _contentText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        _contentText.textColor = [UIColor grayColor];
//        _time.textColor = [UIColor grayColor];
        
       
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
//    UIView* cell = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height, UIScreenWidth, 0.3)];
//    cell.backgroundColor = BackColor;
//    [self addSubview:cell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
}

@end
