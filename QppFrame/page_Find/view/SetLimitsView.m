//
//  SetLimitsView.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "SetLimitsView.h"
#import "Utill.h"

@implementation SetLimitsView
@synthesize limitsList=_limitsList;

-(void)viewDidLoad{

    _limitsList = [[UITableView alloc]init];
//    _limitsList.frame = CGRectMake(0, 0, UIScreenWidth, 40*[lim count]);
    _limitsList.backgroundColor = [UIColor clearColor];
    _limitsList.delegate = self;
    _limitsList.dataSource = self;
    [self addSubview:_limitsList];
    
//    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.frame = CGRectMake(0, theTelephone.frame.origin.y+theTelephone.frame.size.height, [[UIScreen mainScreen] bounds].size.width, contentHeight-theTelephone.frame.size.height);
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView 设置
    
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"TongXuLvCell";
    //自定义cell类
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TongXuLvCell" owner:self options:nil] lastObject];
        //添加测试数据
        
        NSLog(@"indexPath.section:%i,indexPath.row:%i",indexPath.section,indexPath.row);
    }
    cell.textLabel.text = @"aaa";
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"mamamamamamamamamamamammamamamammamammamaamamamm");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UIScreenHeight*0.03;
}
@end
