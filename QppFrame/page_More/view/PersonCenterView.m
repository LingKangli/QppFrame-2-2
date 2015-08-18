//
//  PersonCenter.m
//  Example
//
//  Created by LingKangLi on 15/6/12.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "PersonCenterView.h"
#import "Utill.h"
#import "HeadView.h"

@implementation PersonCenterView
@synthesize tableView = _tableView;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    
    self = [super init];
    if (self) {
//        UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 20)];
//        [backBtn setTitle:@"Back" forState:UIControlStateNormal];
//        [self addSubview:backBtn];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];;
    if (self) {
        
        sectionOne = [NSArray arrayWithObjects:@"名字",@"Qpp号", nil];
        sectionTwo= [NSArray arrayWithObjects:@"性别",@"地区",@"个性签名", nil];
        
        

//        sectionOne = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"名字",@"Qpp号", nil], [NSArray arrayWithObjects:@"名字",@"Qpp号", nil],nil];
        
        HeadView* headView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight*0.32)];
        [self addSubview:headView];
        
                
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
        _tableView.frame = CGRectMake(0, headView.frame.size.height, UIScreenWidth+15, UIScreenHeight*0.4);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
    return self;
}

-(void)backBtn:(id) sender{
//    [UIView animateWithDuration:0.6 animations:^{
//        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        
//    }];

    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView 设置
    
    UITableViewCell* cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight*0.05)];
    switch (indexPath.section) {

        case 0:{
            cell.textLabel.text = [sectionOne objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            if (indexPath.row != 1) {
                UIImageView* enterImg = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*0.9, cell.frame.size.height/2-5, 5, 10)];
                enterImg.image = [UIImage imageNamed:@"jianTou.png"];
                [cell addSubview:enterImg];
            }else{
                UILabel* QppLab = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth*0.8, cell.frame.size.height/2-10, UIScreenWidth*0.6,15)];
                QppLab.font = [UIFont systemFontOfSize:13];
                QppLab.text = @"1024";
                [cell addSubview:QppLab];

            }
        }
            break;
        case 1:
        {
            cell.textLabel.text = [sectionTwo objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            UIImageView* enterImg = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*0.9, cell.frame.size.height/2-5, 5, 10)];
            enterImg.image = [UIImage imageNamed:@"jianTou.png"];
            [cell addSubview:enterImg];
        }
            
            break;
        default:
            break;
    }
//    cell.textLabel.text = @"aaaaaa";
    
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [sectionOne count];
            break;
        case 1:
            return [sectionTwo count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSLog(@"mamamamamamamamamamamammamamamammamammamaamamamm");
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    
    return 20;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

@end
