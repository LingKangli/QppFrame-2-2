//
//  sendInfoView.m
//  Example
//
//  Created by LingKangLi on 15/6/15.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "SendInfoView.h"
#import "Utill.h"

@implementation SendInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{

    self = [super init];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    
    UITextField* wantTosay = [[UITextField alloc]initWithFrame:CGRectMake(0,0, UIScreenWidth, 30)];
    wantTosay.placeholder = @"此时此刻，想和大家分享些什么";
    [self addSubview:wantTosay];

    UIButton* addImgBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, wantTosay.frame.size.height+wantTosay.frame.origin.y+5, 100, 100)];
    [addImgBtn setImage:[UIImage imageNamed:@"u234.png"] forState:UIControlStateNormal];
    [self addSubview:addImgBtn];

//    
//    //Back button
//    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
//    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:backBtn];
//    
//    //title
//    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
//    title.text = @"发表文字";
//    title.textColor = [UIColor whiteColor];
//    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
//    [self addSubview:title];
//    
//    //Back button
//    UIButton* addInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth*0.8, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
//    [addInfoBtn setTitle:@"发表" forState:UIControlStateNormal];
//    [addInfoBtn addTarget:self action:@selector(addInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:addInfoBtn];
//
   /*
    UIView* contentView = [[UIView alloc]initWithFrame:CGRectMake(0,UIScreenHeight*0.12,UIScreenWidth,UIScreenHeight*0.88)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    UIImageView* partView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight*0.88)];
    partView.image = [UIImage imageNamed:@"test.png"];
    [contentView addSubview:partView];
    */
    /*
    UITextField* writeFrameTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, UIScreenWidth, UIScreenHeight*0.05)];
    writeFrameTextField.backgroundColor = [UIColor yellowColor];
    writeFrameTextField.text = @"此时此刻，想和大家分享些什么";
    writeFrameTextField.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:writeFrameTextField];
    
    UIButton* addImg = [[UIButton alloc]initWithFrame:CGRectMake(0, writeFrameTextField.frame.origin.y+writeFrameTextField.frame.size.height, UIScreenWidth*0.2, UIScreenHeight*0.2)];
    addImg.backgroundColor = [UIColor greenColor];
    [addImg addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:addImg];
     */
    return self;

}
-(void)click:(id)sender{
    
    NSLog(@"aaaaa");
    
    
}
-(void)backBtn:(id) sender{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(0, UIScreenHeight, UIScreenWidth, UIScreenHeight);
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableView 设置
    
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"SendInfoCell";
    //自定义cell类
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TongXuLvCell" owner:self options:nil] lastObject];
        //添加测试数据
        
        NSLog(@"indexPath.section:%i,indexPath.row:%i",indexPath.section,indexPath.row);
    }
    cell.textLabel.text = @"";
    
    return cell;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"the section : %i",section);
//    return [headerTitles objectAtIndex:section];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
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



@end
