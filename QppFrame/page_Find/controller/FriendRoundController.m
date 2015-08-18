//
//  FriendRoundController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "FriendRoundController.h"
#import "Utill.h"
#import "FriendsStoryCellTableViewCell.h"
//#import "SendInfoView.h"
#import "SendInfoController.h"
//#import "UIFriendsStoryStyleTwoCellTableVIewCell.h"



@implementation FriendRoundController

@synthesize tableView = _tableView;

-(instancetype)init{
    
    self = [super init];
    NSLog(@"the test");
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                    image:[UIImage imageNamed:@"Qpp"]
                                            selectedImage:[UIImage imageNamed:@"Qpp"]];
    
    imageNames = [NSArray arrayWithObjects:@"2.jpg",@"1.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg", nil];
    namesText = [NSArray arrayWithObjects:@"风度科技",@"宋玮锋",@"傻大个",@"Tony",@"相亲相爱",@"Gao",@"Kaly",@"XiaoMing", nil];
    dataArray = [NSArray arrayWithObjects:@"8:00",@"12:00",@"18:00",@"昨天",@"昨天",@"前天",@"大前天",@"大大前天", nil];
    contentArray =[NSArray arrayWithObjects:@"今天天气真好。",@"想去打篮球。",@"又上去上课了。。。",@"凤凰传奇来广场了。哇噻。",@"朋友说我长得像郭敬明",@"校长又分配下任务来了。",@"那首歌真好听呀。",@"ＤＪ", nil];
    typeArray = [NSMutableArray arrayWithObjects:@"文字",@"图文",@"图文",@"文字",@"图文",@"图文",@"文字",@"图文", nil];
    contentImgDic = [ contentImgDic initWithObjectsAndKeys:
                     @"",@"文字1",
                     @"1.jpg",@"图文2",
                     @"1.jpg",@"图文3",
                     @"wo",@"文字4",
                     @"1.jpg",@"图文5",
                     @"1.jpg",@"图文6",
                     @"",@"文字7",
                     @"1.jpg",@"图文8",nil] ;

    contentImgArray = [NSMutableArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg", nil];
  NSLog(@"---aa:%@",[contentImgDic objectForKey:@"图文3"])  ;
//    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:@"hechen",@"name",@"25",@"age", nil];
//    NSDictionary *dic2=[[NSDictionary alloc] init];
    
//    NSLog(@"%d",[dic count]);
//    NSLog(@"%d",[dic1 count]);
//    NSLog(@"%d",[dic2 count]);
//    NSLog(@"aaaaaa%i",(NSInteger*)[typeArray objectAtIndex:0]);
    
//    typeArray = new ShowType[4];
//    storyArray =  FriendStoryItem[9];
  
    storyArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < 8; i++) {
        FriendStoryItem* fSI = [[FriendStoryItem alloc]init];
        fSI.name = [namesText objectAtIndex:i];
        fSI.dataSend = [dataArray objectAtIndex:i];
        fSI.imgName = [imageNames objectAtIndex:i];
        fSI.story = [contentArray objectAtIndex:i];
        fSI.type = [typeArray objectAtIndex:i];
        fSI.contentImg = [contentImgDic objectForKey:@"图文2"];
        [storyArray addObject:fSI];
        NSLog(@"story:%@",storyArray);
//        storyArray
    }
    return self;
}

-(void)viewDidLoad{
    
    [self hideTabBar]; //隐藏tabBar
    [self hideNavBar];

    self.view.backgroundColor= BackColor;
#pragma TitleView
    //Back button
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //title
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
    title.text = @"朋友圈";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.view addSubview:title];
    
    //Back button
    UIButton* addInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth*0.8, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
    [addInfoBtn setTitle:@"+" forState:UIControlStateNormal];
    [addInfoBtn addTarget:self action:@selector(addInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addInfoBtn];
   
#pragma TableView
    
    //朋友圈内容
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, UIScreenHeight*0.1, UIScreenWidth, UIScreenHeight*0.9)];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


-(void)backBtn:(id) sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self showTabBar];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"myCell";
    //自定义cell类
//    FriendsStoryCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];


    FriendsStoryCellTableViewCell* cell;
    if (cell == nil) {
 
        if ([[typeArray objectAtIndex:indexPath.row] isEqualToString:@"文字"]) {
            cell = [[FriendsStoryCellTableViewCell alloc]init];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendsStoryCellTableViewCell" owner:self options:nil] lastObject];
            //添加测试数据
            NSLog(@"aa%@",((FriendStoryItem*)[storyArray objectAtIndex:indexPath.row]).imgName);
            cell.personImg.image = [UIImage imageNamed:((FriendStoryItem*)[storyArray objectAtIndex:indexPath.row]).imgName];
            cell.personName.text = ((FriendStoryItem*)[storyArray objectAtIndex:indexPath.row]).name;
            cell.personInfo.text = ((FriendStoryItem*)[storyArray objectAtIndex:indexPath.row]).story;
            cell.infoDate.text = ((FriendStoryItem*)[storyArray objectAtIndex:indexPath.row]).dataSend;
//            cell.personImg.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
//            cell.personName.text = [namesText objectAtIndex:indexPath.row];
//            cell.personInfo.text =[contentArray objectAtIndex:indexPath.row];
//            cell.infoDate.text = [dataArray objectAtIndex:indexPath.row];
        }

        if ([[typeArray objectAtIndex:indexPath.row] isEqualToString:@"图文"]) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendStoryImgCellTableViewCell" owner:self options:nil] lastObject];
            //添加测试数据
            cell.personImg.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
            cell.personName.text = [namesText objectAtIndex:indexPath.row];
            cell.personInfo.text =[contentArray objectAtIndex:indexPath.row];
            cell.infoDate.text = [dataArray objectAtIndex:indexPath.row];
            cell.imgView.image = [UIImage imageNamed:[contentImgArray objectAtIndex:indexPath.row]];
            NSLog(@"qq:%@",[contentImgDic objectForKey:@"图文2"]);
        
        }
       
//        if ([cell isEqual:@"图文"]) {
//          
//
//           
//        }
//            case 0:{
         //            }
//                break;
//                
//            default:{
//                cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendStoryImgCellTableViewCell" owner:self options:nil] lastObject];
//                //添加测试数据
//                cell.personImg.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
//                cell.personName.text = [namesText objectAtIndex:indexPath.row];
//                cell.personInfo.text =[contentArray objectAtIndex:indexPath.row];
//                cell.infoDate.text = [dataArray objectAtIndex:indexPath.row];
//                cell.imgView.image = [UIImage imageNamed:@"1.jpg"];
//            }
//                
//                break;
//        }
         }
     
    
//    static NSString* cellwithIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellwithIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        UIImageView* touXiangImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//        touXiangImg.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
//        [cell addSubview:touXiangImg];
//    }
    return cell;
}

-(void)addInfoBtn:(id) sender{
    
    SendInfoController* sIC= [[SendInfoController alloc]init];
    [self hideTabBar];
    [self.navigationController setNavigationBarHidden:YES];//顶部的NavigationBar显示情况
    [self.navigationController pushViewController:sIC animated:YES];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [namesText count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[typeArray objectAtIndex:indexPath.row] isEqualToString:@"文字"]) {
        return 120;
    }
    if ([[typeArray objectAtIndex:indexPath.row] isEqualToString:@"图文"]) {
        return 210;
    }
    return 210;
    
//    switch ([typeArray objectAtIndex: indexPath.row] isEqual:@) {
//        case 0:
//            return 120 ;
//            break;
//        
//            
//        default:
//            return 210;
//            break;
//    }
//    return 120;
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
    
    //    ChatView* chatView = [[ChatView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
    //    ;
    //    [UIView animateWithDuration:0.6 animations:^{
    //        chatView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    //    } completion:^(BOOL finished) {
    //
    //    }];
    //    [self.view addSubview:chatView];
    
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
@end
