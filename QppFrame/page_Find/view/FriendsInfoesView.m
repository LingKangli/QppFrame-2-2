//
//  FriendsInfoesView.m
//  Example
//
//  Created by LingKangLi on 15/6/11.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "FriendsInfoesView.h"
#import "Utill.h"
#import "FriendsStoryCellTableViewCell.h"
#import "Utill.h"
#import "SendInfoView.h"

@implementation FriendsInfoesView
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
      
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = BackColor;
    if (self) {
        //Back button
        UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        //title
        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
        title.text = @"朋友圈";
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self addSubview:title];
        
        //Back button
        UIButton* addInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth*0.8, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
        [addInfoBtn setTitle:@"+" forState:UIControlStateNormal];
        [addInfoBtn addTarget:self action:@selector(addInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addInfoBtn];
        
        //朋友圈内容
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, UIScreenHeight*0.12, UIScreenWidth, UIScreenHeight*0.8)];

        _tableView.backgroundColor = [UIColor redColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        
        imageNames = [NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg", nil];
        namesText = [NSArray arrayWithObjects:@"风度科技",@"宋玮锋",@"傻大个",@"Tony",@"相亲相爱",@"Gao",@"Kaly",@"XiaoMing", nil];
        dataArray = [NSArray arrayWithObjects:@"8:00",@"12:00",@"18:00",@"昨天",@"昨天",@"前天",@"大前天",@"大大前天", nil];
        contentArray =[NSArray arrayWithObjects:@"今天天气真好。",@"想去打篮球。",@"又上去上课了。。。",@"凤凰传奇来广场了。哇噻。",@"朋友说我长得像郭敬明",@"校长又分配下任务来了。",@"那首歌真好听呀。",@"ＤＪ", nil];
        

        
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"myCell";
    //自定义cell类
    FriendsStoryCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendsStoryCellTableViewCell" owner:self options:nil] lastObject];
        //添加测试数据
        
    }
    cell.personImg.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
    cell.personName.text = [namesText objectAtIndex:indexPath.row];
    cell.personInfo.text =[contentArray objectAtIndex:indexPath.row];
    cell.infoDate.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}


-(void)backBtn:(id) sender{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

-(void)addInfoBtn:(id) sender{
    
//    SendInfoView* sIV = [[SendInfoView alloc]initWithFrame:CGRectMake(0,UIScreenHeight, UIScreenWidth, UIScreenHeight)];
//    sIV.backgroundColor = BackColor;
//    [self addSubview:sIV];
    
//    [UIView animateWithDuration:0.6 animations:^{
//        self.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
//    } completion:^(BOOL finished) {
//        
//    }];
    
    
    SendInfoView* sIV = [[SendInfoView alloc]initWithFrame:CGRectMake(0,UIScreenHeight, UIScreenWidth, UIScreenHeight)];
    sIV.backgroundColor = BackColor;
    
    [UIView animateWithDuration:0.6 animations:^{
        sIV.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
    [self addSubview:sIV];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    return [mainInfoRoot count];
    //    return [namesText count];
//    return [perImgNameArray count];

    return [namesText count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
