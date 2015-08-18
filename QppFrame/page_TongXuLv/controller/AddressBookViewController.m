//
//  AddressBookViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "AddressBookViewController.h"
#import "Utill.h"

@interface AddressBookViewController ()

@end

@implementation AddressBookViewController

-(instancetype)init{
    self = [super init];

//    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Qpp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    self.tabBarItem.image = [[UIImage imageNamed:@"Qpp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self hideNavBar];
    
    headerTitles = [[NSArray alloc]initWithObjects:@"a", @"b", @"c", @"d",@"e",@"f",@"g",@"h",@"j",@"k",@"l",@"m",@"n",@"o", nil];
    contentTitles =  [[NSArray alloc] initWithObjects:
                      [NSArray arrayWithObjects:@"aa", @"ab", nil],
                      [NSArray arrayWithObjects:@"ba", @"bb", @"bc", nil],
                      [NSArray arrayWithObjects:@"ca", @"cb", @"cc", @"cd", nil],
                      [NSArray arrayWithObjects:@"da", @"db", @"dc", @"de", @"df",nil],
                      [NSArray arrayWithObjects:@"ea", @"eb", @"ec", @"ed", @"ee",@"ef",nil],
                      [NSArray arrayWithObjects:@"fa", @"fb", @"fc", @"fd", @"fe",@"ff",@"fg",nil],
                      
                      [NSArray arrayWithObjects:@"ga", @"gb", @"gc", @"gd", @"ge",@"gf",@"gg",nil],
                      
                      [NSArray arrayWithObjects:@"ha", @"hb", @"hc", @"hd", @"he",@"hf",@"hg",nil],
                      
                      [NSArray arrayWithObjects:@"ja", @"jb", @"jc", @"jd", @"je",@"jf",nil],
                      
                      [NSArray arrayWithObjects:@"ka", @"kb", @"kc", @"kd", @"ke",@"kf",nil],
                      
                      [NSArray arrayWithObjects:@"la", @"lb", @"lc", @"ld", @"ee",@"ef",nil],
                      
                      [NSArray arrayWithObjects:@"ma", @"mb", nil],
                      
                      [NSArray arrayWithObjects:@"na", @"nb", @"nc",nil],
                      
                      [NSArray arrayWithObjects:@"oa", @"ob", @"oc", @"od", nil],
                      nil];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    // Do any additional setup after loading the view.
    [self hideNavBar];
    
    self.view.backgroundColor = BackColor;
    
    
    //title
    UILabel* QppTitle = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, 7, 50, 60)];
    QppTitle.text = @"通讯录";
    QppTitle.textColor = [UIColor whiteColor];
    QppTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [self.view addSubview:QppTitle];
    
    UIButton* addPerson = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth/2+120, 30, 20, 20)];
    [addPerson setImage:[UIImage imageNamed:@"Qpp_addPerson.png"] forState:UIControlStateNormal];
    [addPerson addTarget:self action:@selector(clickBtn
                                               ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPerson];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, addPerson.frame.origin.y+addPerson.frame.size.height+5, UIScreenWidth, 0.3)];
    imageView.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:imageView];
    
    
    UISearchBar* search  = [[UISearchBar alloc]init];
    search.delegate = self;
    search.barTintColor = BackColor;
    search.frame = CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, UIScreenWidth, searchHeight) ;
    [self.view addSubview:search];
    
    UILabel* theTelephone = [[UILabel alloc]initWithFrame:CGRectMake(0, search.frame.origin.y+search.frame.size.height, UIScreenWidth, UIScreenHeight*0.07)];
    theTelephone.backgroundColor = [UIColor whiteColor];
    theTelephone.text = @"本机号码: 13623474671";
    theTelephone.textColor = [UIColor blackColor];
    theTelephone.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:theTelephone];
    
    // Do any additional setup after loading the view from its nib.
    
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.frame = CGRectMake(0, theTelephone.frame.origin.y+theTelephone.frame.size.height, [[UIScreen mainScreen] bounds].size.width, contentHeight-theTelephone.frame.size.height-27);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //    设置索引中的内容

    [self.view addSubview:_tableView];
    
    UIImageView* lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height+_tableView.frame.origin.y, UIScreenWidth, 0.3)];
    lineImageView.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:lineImageView];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TongXuLvCell" owner:self options:nil] lastObject];
        //添加测试数据
        
        NSLog(@"indexPath.section:%i,indexPath.row:%i",indexPath.section,indexPath.row);
    }
    cell.textLabel.text = [[contentTitles objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  

    if ([headerTitles count]== 0 ) {
        return @"";
    }
    NSLog(@"the section : %i",section);
    return [headerTitles objectAtIndex:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[contentTitles objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"mamamamamamamamamamamammamamamammamammamaamamamm");
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UIScreenHeight*0.03;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [headerTitles count];
}

//设置tableView索引
//添加索引列


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

{
    NSLog(@"aaaaa %@",headerTitles);
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
        
    {
        return nil;
    }
    
    return headerTitles;
    
}


//索引列点击事件

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{
 
    NSInteger count = 0;
    
    for (NSString* character in headerTitles) {
        if ([character isEqualToString:title]) {
            return count;
        }
        count++;
    }
    return 0;
    /*
    NSLog(@"===%@  ===%d",title,index);
    
    //点击索引，列表跳转到对应索引的行
    
    [tableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index+4]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //弹出首字母提示
    
//    [self showLetter:title ];
    
    return index+4;
     */
    
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
