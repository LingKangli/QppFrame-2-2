//
//  FindViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "FindViewController.h"
#import "Utill.h"
//#import "FriendsInfoesView.h"
#import "ShoppingView.h"
#import "FriendRoundController.h"
#import "FindPageCell.h"

@interface FindViewController ()

@end

@implementation FindViewController

@synthesize tableView = _tableView;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Qpp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"Qpp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
//        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
//                                                        image:[UIImage imageNamed:@"camera_normal"]
//                                                selectedImage:[UIImage imageNamed:@"camera_pressed"]];
        findContent = [[NSArray alloc]initWithObjects:@"朋友圈",@"购物", nil];
        imgArray = [[NSArray alloc]initWithObjects:@"friendRound.png",@"shopping.png" ,nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self hideNavBar];
    self.view.backgroundColor = BackColor;
    
    //title
    UILabel* QppTitle = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, 10, 50, 50)];
    QppTitle.text = @"发现";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView 设置
    
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"TongXuLvCell";
    //自定义cell类
    FindPageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FindPageCell" owner:self options:nil] lastObject];
        //添加测试数据
//        cell.textLabel.text = [findContent objectAtIndex:indexPath.section];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        NSLog(@"indexPath.section:%i,indexPath.row:%i",indexPath.section,indexPath.row);

        cell.nameLab.text = [findContent objectAtIndex:indexPath.section];
        cell.imgIcon.image = [UIImage imageNamed:[imgArray objectAtIndex:indexPath.section]];
        
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"mamamamamamamamamamamammamamamammamammamaamamamm");
    
    /* FriendsInfoesView* friendsIV = [[UIView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight)];
     [self.view addSubview:<#(UIView *)#>];
     */
    switch (indexPath.section) {
        case 0:{
            
            FriendRoundController* fRC = [[FriendRoundController alloc]init];
            [self.navigationController setNavigationBarHidden:YES];//顶部的NavigationBar显示情况
            [self hideTabBar];

            [self.navigationController pushViewController:fRC animated:YES];
            
//            FriendsInfoesView* chatView = [[FriendsInfoesView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
//            ;
//            [UIView animateWithDuration:0.6 animations:^{
//                chatView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
//            } completion:^(BOOL finished) {
//                
//            }];
//            [self.view addSubview:chatView];
          
            
        }
            break;
        case 1:{
            ShoppingView* shopping = [[ShoppingView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
            ;
            [UIView animateWithDuration:0.6 animations:^{
                shopping.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
            } completion:^(BOOL finished) {
                
            }];
            [self.view addSubview:shopping];
        }
            break;
        default:
            break;
    }
    
    
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [findContent count];
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
