//
//  BiaoQingController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "BiaoQingController.h"
#import "Utill.h"
#import "BiaoQingView.h"
#import "BiaoPingCellTableViewCell.h"
#import "SettingView.h"

@implementation BiaoQingController
-(instancetype)init{

    self = [super init];
    perImgNameArray = [[NSArray  alloc]initWithObjects:@"biaoQingImg1.jpg",@"biaoQingImg2.jpg",@"biaoQingImg3.jpg",@"biaoQingImg4.png",@"biaoQingImg5.jpg",@"biaoQingImg6.png",@"biaoQingImg7.jpg",@"biaoQingImg8.png",@"biaoQingImg9.jpg", nil];
    
    nameLabArray = [[NSArray  alloc]initWithObjects:@"duang!",@"抱大腿",@"囧",@"I'm coming",@"噗。。。",@"胶水",@"反加班",@"大白",@"懒人", nil];//头像图片数组
    
    contentLabArray = [[NSArray alloc]initWithObjects:@"duang!22",@"抱大腿2",@"囧2",@"I'm coming2",@"噗。。。2",@"胶水2",@"反加班2",@"大白2",@"懒人2", nil];
    isDownImgNameArray = [[NSArray alloc]initWithObjects:@"downImg.png",@"downImg.png",@"downImg.png",@"downImg.png",@"downImg.png",@"downImg.png",@"downImg.png",@"downImg.png",@"downImg.png", nil];

    return self;
}
-(void)viewDidLoad{
    
    [super viewDidLoad];
    BiaoQingView* pCV = [[BiaoQingView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self.view addSubview:pCV];
    [self hideTabBar];
    //Back button
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
    title.text = @"表情";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.view addSubview:title];
    
    UIImageView* expImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+title.frame.size.height, UIScreenWidth, UIScreenHeight*0.2)];
    expImg.image = [UIImage imageNamed:@"titleBack.png"];
    [self.view addSubview:expImg];
    

    
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.frame = CGRectMake(0, expImg.frame.origin.y+expImg.frame.size.height, [[UIScreen mainScreen] bounds].size.width,UIScreenHeight*0.7);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

-(void)backBtn:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self showTabBar];
    NSLog(@"aaa");
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView 设置
    
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"biaoPingCell";
    //自定义cell类
    BiaoPingCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BiaoPingCellTableViewCell" owner:self options:nil] lastObject];
        //添加测试数据
        
    }
//    cell.textLabel.text = @"aaaaaaa";
    cell.BiaoPingImg.image = [UIImage imageNamed:[perImgNameArray objectAtIndex:indexPath.row]];
//    cell.explainLab.text = @"aaaa";
    cell.nameLab.text = [nameLabArray objectAtIndex:indexPath.row];
    cell.explainLab.text = [contentLabArray objectAtIndex:indexPath.row];
    cell.explainLab.textColor = [UIColor grayColor];
    [cell.isDown setImage:[UIImage imageNamed:[isDownImgNameArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    
    [cell.isDown addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [cell.isDown setBackgroundColor:[UIColor yellowColor]];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    return [mainInfoRoot count];
    //    return [namesText count];
    return [nameLabArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    HomeTableViewCell* cell = (HomeTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    //    cell.rightImage.image = [UIImage imageNamed:@"book_right_open"];
    
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    /*
     #pragma mark goToNextPage ---- navigationController
     
     ModeFromHomeViewController* modeController = [[ModeFromHomeViewController alloc]initWithNibName:@"ModeFromHomeViewController" bundle:nil];
     self.delegate = modeController;
     //    NSLog(@"((BookMainInfo*)[mainInfoRoot objectAtIndex:indexPath.row]).bookMainTitle::::%@",((BookMainInfo*)[mainInfoRoot objectAtIndex:indexPath.row]).bookMainTitle);
     [self.navigationController pushViewController:modeController animated:NO];
     [delegate pushValue:(BookMainInfo*)[mainInfoRoot objectAtIndex:indexPath.row] pushTitle:PageRoot];
     */
    
    SettingView* settingView = [[SettingView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
    ;
    [UIView animateWithDuration:0.6 animations:^{
        settingView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
    [self.view addSubview:settingView];
    
    /*
     if (tableView == waiteToDoTable) {
     TaskDetailViewController *taskDetail = [[TaskDetailViewController alloc] init];
     [self.navigationController pushViewController:taskDetail animated:YES];
     }else if (tableView == projectTable){
     [self.navigationController pushViewController:notificationManageView animated:YES];
     }else if (tableView == caseTable){
     [self.navigationController pushViewController:notificationManageView animated:YES];
     }else if (tableView == taskTable){
     [self.navigationController pushViewController:notificationManageView animated:YES];
     }else if (tableView == partsTable){
     [self.navigationController pushViewController:notificationManageView animated:YES];
     }else if (tableView == publicTable){
     [self.navigationController pushViewController:notificationManageView animated:YES];
     }else if (tableView == otherTable){
     [self.navigationController pushViewController:notificationManageView animated:YES];
     }*/
    
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"mamamamamamamamamamamammamamamammamammamaamamamm");
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(void)click{
    NSLog(@"aaaa");
    
}
@end
