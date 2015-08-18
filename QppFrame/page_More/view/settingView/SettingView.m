//
//  SettingView.m
//  Example
//
//  Created by LingKangLi on 15/6/13.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "SettingView.h"
#import "Utill.h"
#import "ReviseView.h"
#import "DefineBG.h"
//#import "<#header#>"
@implementation SettingView

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
//        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        //title
        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
        title.text = @"设置";
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self addSubview:title];
        
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
        _tableView.frame = CGRectMake(0, title.frame.origin.y+title.frame.size.height+5, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height*0.9);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = NO;//去掉tableview的分割线
        
        [self addSubview:_tableView];
        
        findContent = [[NSArray alloc]initWithObjects:@"修改密码",@"关于Qpp",@"退出登录", nil];

        //Back button
//        UIButton* addInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth*0.8, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
//        [addInfoBtn setTitle:@"+" forState:UIControlStateNormal];
//        [addInfoBtn addTarget:self action:@selector(addInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:addInfoBtn];
        
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView 设置
    
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"TongXuLvCell";
    //自定义cell类
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"FindPageCell" owner:self options:nil] lastObject];
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //添加测试数据
        switch (indexPath.section) {
            case 2:{
                
                UILabel* testLab = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, 2, UIScreenWidth/2, 50)];
                testLab.text =[findContent objectAtIndex:indexPath.section];
                testLab.textColor = [UIColor redColor];
                [cell addSubview:testLab];
                 NSLog(@"indexPath.section:%i,indexPath.row:%i",indexPath.section,indexPath.row);
                
                break;
            }
                
            default:{
                
                UILabel* testLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, UIScreenWidth/2, 50)];
                testLab.text =[findContent objectAtIndex:indexPath.section];
                testLab.textColor = [UIColor blackColor];
                [cell addSubview:testLab];
                NSLog(@"indexPath.section:%i,indexPath.row:%i",indexPath.section,indexPath.row);
                
                UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth*0.9, 17, 8, 15)];
                img.image = [UIImage imageNamed:@"jianTou.png"];
                [cell addSubview:img];
                
                break;
            }
                /*
                cell.textLabel.text = [findContent objectAtIndex:indexPath.section];
                NSLog(@"indexPath.section:%i,indexPath.row:%i",indexPath.section,indexPath.row);
                break;
                */

                break;
        }
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"mamamamamamamamamamamammamamamammamammamaamamamm");
    
    /* FriendsInfoesView* friendsIV = [[UIView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight)];
     [self.view addSubview:<#(UIView *)#>];
     */
    
    switch (indexPath.section) {
        case 0:{
            ReviseView* settingView = [[ReviseView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
            ;
            [UIView animateWithDuration:0.6 animations:^{
                settingView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
            } completion:^(BOOL finished) {
                
            }];
            [self addSubview:settingView];
        }
            break;
        case 1:
        {
            
//            ShoppingView* shopping = [[ShoppingView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, UIScreenWidth , UIScreenHeight)]
//            ;
//            [UIView animateWithDuration:0.6 animations:^{
//                shopping.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
//            } completion:^(BOOL finished) {
//                
//            }];
//            [self.view addSubview:shopping];
        }
            break;
        default:
            break;
    }
    
    
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [findContent count];
}


-(void)backBtn:(id) sender{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

-(void)addInfoBtn:(id) sender{
    
    
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(UIScreenWidth, 0, UIScreenWidth, UIScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

@end
