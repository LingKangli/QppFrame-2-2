//
//  MoreViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "MoreViewController.h"
#import "Utill.h"
#import "PersonCenterController.h"
#import "BiaoQingController.h"
#import "SettingController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
-(instancetype)init{
    self = [super init];
    //    self.view.backgroundColor = [UIColor greenColor];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Qpp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.image = [[UIImage imageNamed:@"Qpp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self hideNavBar];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideNavBar];

    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor grayColor]];

    self.view.backgroundColor = BackColor;
    //title
    UILabel* QppTitle = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, 10, 50, 50)];
    QppTitle.text = @"更多";
    QppTitle.textColor = [UIColor whiteColor];
    QppTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [self.view addSubview:QppTitle];
    
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    _tableView.frame = CGRectMake(0, QppTitle.frame.origin.y+QppTitle.frame.size.height, [[UIScreen mainScreen] bounds].size.width, contentTheHeight);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = NO;//去掉tableview的分割线
    
    [self.view addSubview:_tableView];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"aaa"
//                                                        image:[UIImage imageNamed:@"more.png"]
//                                                selectedImage:[UIImage imageNamed:@"more.png"]];
        
        
        moreList = [[NSArray alloc]initWithObjects:@"个人中心",@"表情",@"设置", nil];
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView 设置
    
    
    /*
     switch (indexPath.section) {
     case 0:{
     
     static NSString *CellIdentifier = @"moreItemMyInfo";
     //自定义cell类
     MoreItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     //通过xib的名称加载自定义的cell
     //添加测试数据
     //        cell.enterImg.image = [UIImage imageNamed:@"jianTou.png"];
     cell.nameText.text = @"name";
     }
     return cell;
     }
     break;
     
     default:{
     
     static NSString *CellIdentifier = @"moreItemSingle";
     //自定义cell类
     MoreOneItemCell *moreCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (moreCell == nil) {
     //通过xib的名称加载自定义的cell
     //添加测试数据
     //        cell.enterImg.image = [UIImage imageNamed:@"jianTou.png"];
     moreCell.itemTitle.text = @"the text...";
     
     }
     return moreCell;
     }
     break;
     }
     //指定cellIdentifier为自定义的cell
     */
    UITableViewCell* cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    switch (indexPath.section) {
        case 0:{
            UIImageView* perImg = [[UIImageView alloc]initWithFrame:CGRectMake(7, 8, 50, 50)];
            perImg.image = [UIImage imageNamed:@"u262.png"];
            [cell addSubview:perImg];
            
            UILabel* nameLab = [[UILabel alloc]initWithFrame:CGRectMake(perImg.frame.size.width+perImg.frame.origin.x+10, perImg.frame.origin.y+5, 120, 20)];
            nameLab.text = @"个人中心";
            //            nameLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
            nameLab.font = [UIFont systemFontOfSize:13];
            [cell addSubview:nameLab];
            
            UILabel* timeLab = [[UILabel alloc]initWithFrame:CGRectMake(nameLab.frame.origin.x, nameLab.frame.origin.y+nameLab.frame.size.height, UIScreenWidth*0.7, 20)];
            timeLab.text = @"Qpp ID:1022030";
            //            timeLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
            timeLab.font = [UIFont systemFontOfSize:10];
            timeLab.textColor = [UIColor grayColor];
            [cell addSubview:timeLab];
            
            UIImageView* enterImg = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*0.9, cell.frame.origin.y+30, 5, 10)];
            enterImg.image = [UIImage imageNamed:@"jianTou.png"];
            [cell addSubview:enterImg];
        }
            break;
        case 1:{
            
            UIImageView* biaoQinImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 20, 20)];
            biaoQinImg.image = [UIImage imageNamed:@"biaoQing.png"];
            [cell addSubview:biaoQinImg];
            
            UILabel* cellName = [[UILabel alloc]initWithFrame:CGRectMake(biaoQinImg.frame.origin.x+biaoQinImg.frame.size.width + 10,3, 40, 30)];
            cellName.text =  @"表情";
            cellName.font = [UIFont systemFontOfSize:14];
            [cell addSubview:cellName];
            
            
            UIImageView* enterImg = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*0.9, cell.frame.origin.y+12, 5, 10)];
            enterImg.image = [UIImage imageNamed:@"jianTou.png"];
            [cell addSubview:enterImg];
            
        }
            
            break;
        case 2:{
            UIImageView* biaoQinImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 20, 20)];
            biaoQinImg.image = [UIImage imageNamed:@"setting.png"];
            [cell addSubview:biaoQinImg];
            
            UILabel* cellName = [[UILabel alloc]initWithFrame:CGRectMake(biaoQinImg.frame.origin.x+biaoQinImg.frame.size.width+10, biaoQinImg.frame.origin.y-5, 40, 30)];
            cellName.text =  @"设置";
            cellName.font = [UIFont systemFontOfSize:14];
            [cell addSubview:cellName];
            
            UIImageView* enterImg = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*0.9, cell.frame.origin.y+12, 5, 10)];
            enterImg.image = [UIImage imageNamed:@"jianTou.png"];
            [cell addSubview:enterImg];
            
        }
            
            break;
        default:
            break;
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 65;
            
        default:
            return 35;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"mamamamamamamamamamamammamamamammamammamaamamamm");
    
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case 0:{
            PersonCenterController * pCC = [[PersonCenterController alloc]init];
            [self.navigationController pushViewController:pCC animated:YES];
            //            PersonCenterView* pCView = [[PersonCenterView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
//            ;
//            [UIView animateWithDuration:0.6 animations:^{
//                pCView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
//            } completion:^(BOOL finished) {
//                
//            }];
//            [self.view addSubview:pCView];
        }
            break;
        case 1:{
            BiaoQingController* bQC = [[BiaoQingController alloc]init];
            [self.navigationController pushViewController:bQC animated:YES];
//            BiaoQingView* pCView = [[BiaoQingView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
//            ;
//            [UIView animateWithDuration:0.6 animations:^{
//                pCView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
//            } completion:^(BOOL finished) {
//                
//            }];
//            [self.view addSubview:pCView];
        }
            
            break;
        case 2:{
            SettingController* sC = [[SettingController alloc]init];
            [self.navigationController pushViewController:sC animated:YES];
//            SettingView* settingView = [[SettingView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
//            ;
//            [UIView animateWithDuration:0.6 animations:^{
//                settingView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
//            } completion:^(BOOL finished) {
//                
//            }];
//            [self.view addSubview:settingView];
        }
            
            break;
        default:
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20.0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //    return [findContent count];
    return [moreList count];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
