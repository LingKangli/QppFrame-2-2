//
//  QppViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "QppViewController.h"
#import "Utill.h"
#import "QppViewCell.h"
#import "ChatViewController.h"
#import "AppDelegate.h"
#import "AddressBookViewController.h"
#import "MoreViewController.h"
#import "TabBarViewController.h"

@interface QppViewController ()

@end

@implementation QppViewController

-(instancetype)init{
    self = [super init];

    [self hideNavBar];
    return self;
}

@synthesize tableView = _tableView;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        //        数据存储处
        imageNames = [NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg", nil];
        namesText = [NSArray arrayWithObjects:@"风度科技",@"宋玮锋",@"傻大个",@"Tony",@"相亲相爱",@"Gao",@"Kaly",@"XiaoMing", nil];
        dataArray = [NSArray arrayWithObjects:@"08:00",@"12:00",@"18:00",@"昨天",@"昨天",@"前天",@"周二",@"周一", nil];
        contentArray =[NSArray arrayWithObjects:@"你领取了宋玮锋的红包",@"嗯嗯，好哒",@"［惊呆了］",@"孙晨",@"郝佳男：嗯",@"OK",@"very ok",@"KFC", nil];
        
        isAdd = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hideNavBar];
    self.view.backgroundColor = BackColor;
    //title
    UILabel* QppTitle = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, 10, 50, 70)];
    QppTitle.text = @"Qpp";
    QppTitle.textColor = [UIColor whiteColor];
    QppTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [self.view addSubview:QppTitle];
    
    UIButton* addPerson = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth/2+120, 35, 20, 20)];
    [addPerson setImage:[UIImage imageNamed:@"Qpp_addPerson.png"] forState:UIControlStateNormal];
    [addPerson addTarget:self action:@selector(clickBtn
                                               ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPerson];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, addPerson.frame.origin.y+addPerson.frame.size.height+10, UIScreenWidth, 0.3)];
    imageView.image = [UIImage imageNamed:@"line.png"];
    
    search  = [[UISearchBar alloc]init];
    search.barTintColor = BackColor;
    search.frame = CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height+10, UIScreenWidth, searchHeight) ;
    search.delegate = self;
    [self.view addSubview:search];
    
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheBefordView)];
//    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view from its nib.
    
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.frame = CGRectMake(0, search.frame.origin.y+search.frame.size.height, [[UIScreen mainScreen] bounds].size.width, contentHeight);
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.allowsSelection=NO;
//    清除UITableView底部多余的分割线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:v];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [_tableView setSeparatorInset:(UIEdgeInsetsMake(200, 0, 0, 0))];
//    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//    }
    [self.view addSubview:_tableView];
    
    UIImageView* lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height+_tableView.frame.origin.y, UIScreenWidth, 0.3)];
    lineImageView.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:lineImageView];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:20.f];
    [self.view addConstraint:constraint];
    
//    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//    btn.backgroundColor = [UIColor greenColor];
//    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:btn];
    
    
    
}


-(void)clickTheBefordView{

//    if (search isExclusiveTouch) {
        [search resignFirstResponder];
//    }
    NSLog(@"click the btn");
}
//table Delegate
/*
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 static NSString* showUserInfoCellIdentifier = @"myCell";
 QppViewCell* cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
 if (cell == nil) {
 cell = [[QppViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:showUserInfoCellIdentifier];
 cell.personImg.image = [UIImage imageNamed:@"user_normal.png"];
 cell.nameText.text = @"name";
 cell.time.text = @"2015.05.06";
 cell.contentText.text = @"the content";
 }
 return cell;
 }
 */

-(void)click{
   
    ChatViewController* cVC = [[ChatViewController alloc]init];
    [self.navigationController setNavigationBarHidden:YES];//顶部的NavigationBar显示情况
    [self.navigationController pushViewController:cVC animated:YES];
    [self hideTabBar];
    
    
}



-(void)clickBtn{
    if (!isAdd) {
        
        isAdd = YES;
        popView = [[PopView alloc]initWithFrame:CGRectMake(0, UIScreenHeight, UIScreenWidth, UIScreenHeight*0.3)]
        ;
        [self.view addSubview:popView];
        
        [UIView animateWithDuration:0.6 animations:^{
            popView.frame = CGRectMake(0, UIScreenHeight*0.7, UIScreenWidth, UIScreenHeight*0.3);
        } completion:^(BOOL finished) {
            
        }];
        // 要做的
        [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    }else{
        isAdd = NO;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView 设置
    
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"myCell";
    //自定义cell类
    QppViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QppViewCell" owner:self options:nil] lastObject];
        //添加测试数据
        cell.personImg.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
        cell.nameText.text = [namesText objectAtIndex:indexPath.row];
        cell.time.text = [dataArray objectAtIndex:indexPath.row];
        cell.contentText.text = [contentArray objectAtIndex:indexPath.row];
        cell.selected  = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    return [mainInfoRoot count];
    return [namesText count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    ChatViewController* cVC = [[ChatViewController alloc]init];
    [self.navigationController pushViewController:cVC animated:YES];//调用ChatViewController
    [search resignFirstResponder];

}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //    sendView.frame = CGRectMake(0, cRV.frame.size.height+cRV.frame.origin.y, UIScreenWidth, UIScreenHeight*0.3);
    
    
    //当textField不再是第一监听者时键盘关闭
    
//    [self.sendMessageField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    
//    [searchBar resignFirstResponder];
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheBefordView)];
//    [self.view addGestureRecognizer:tap];
//
//}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//
//    [search resignFirstResponder];
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheBefordView)];
//    [self.view addGestureRecognizer:tap];
//
//}

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
