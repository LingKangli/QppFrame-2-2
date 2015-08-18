//
//  SendInfoController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "SendInfoController.h"
#import "Utill.h"
#import "SendInfoView.h"
#import "SetLimitsView.h"

@implementation SendInfoController
@synthesize limitsList=_limitsList;

-(instancetype)init{

   self = [super init];
    limitsList = [[NSArray alloc]initWithObjects:@"谁可以看",@"提醒谁看" ,nil];
   return self;
}

-(void)viewDidLoad{

    self.view.backgroundColor = BackColor;
#pragma titleView
    //Back button
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //title
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
    title.text = @"发表文字";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.view addSubview:title];
    
    //Back button
    UIButton* addInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth*0.8, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
    [addInfoBtn setTitle:@"发表" forState:UIControlStateNormal];
    [addInfoBtn addTarget:self action:@selector(addInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addInfoBtn];

#pragma sendInfoView
    
    SendInfoView* sIV = [[SendInfoView alloc]initWithFrame:CGRectMake(0, sendInfoY,  UIScreenWidth, UIScreenHeight)];
    sIV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sIV];

#pragma setLimitsView


    
    
    _limitsList = [[UITableView alloc]init];
    _limitsList.frame = CGRectMake(0, sIV.frame.origin.y+UIScreenHeight*0.3, UIScreenWidth,40*[limitsList count]);
    _limitsList.backgroundColor = [UIColor whiteColor];
    _limitsList.scrollEnabled = NO;
//    _limitsList.layer.borderWidth = 1;
//    _limitsList.layer.borderColor = [[UIColor grayColor] CGColor];//设置列表边框
    _limitsList.delegate = self;
    _limitsList.dataSource = self;
    [self.view addSubview:_limitsList];
    
    UIImageView* topLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.3)];
    topLine.image = [UIImage imageNamed:@"line.png"];
    [_limitsList addSubview:topLine];
 
    UIImageView* bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.3)];
    bottomLine.image = [UIImage imageNamed:@"line.png"];
    [_limitsList addSubview:bottomLine];

    
}

#pragma tableView
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
    cell.textLabel.text = [limitsList objectAtIndex:indexPath.row];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [limitsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"mamamamamamamamamamamammamamamammamammamaamamamm");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return UIScreenHeight*0.03;
//}

#pragma btnFunction
-(void)click:(id)sender{
    NSLog(@"aaaaa");
}

//返回按钮方法
-(void)backBtn:(id) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addInfoBtn:(id) sender{
//    [UIView animateWithDuration:0.6 animations:^{
//        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        
//    }];
    [self.navigationController popViewControllerAnimated:YES];

}
@end
