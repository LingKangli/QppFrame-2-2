//
//  ChatViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatView.h"
#import "Utill.h"
#import "QppViewController.h"
#import "ChatRecordView.h"

//#import "ChatEachWritingCell.h"
//#import "ChatEachPicCell.h"
//#import "ChatEachVoiceCell.h"

//#import "Command.h"
#import "MoveButton.h"
#import "KeyBoradView.h"
#import "KeyBoradContentView.h"
#import "MultChatObj.h"
#import "ECDeviceHeaders.h"
#import "DeviceChatHelper.h"
#import "DeviceDelegateHelper.h"
#import "ZipArchive.h"
#define ContentCGRect CGRectMake(0, titleY+titleHeight, UIScreenWidth, UIScreenHeight-titleHeight)
#define  kUTTypeImage @".png"

@implementation ChatViewController
@synthesize backBtn = _backBtn;
@synthesize titleValue = _titleValue;
//@synthesize block;
+(ChatViewController *)sharedInstance
{
    static ChatViewController *chatviewController;
    static dispatch_once_t chatviewControlleronce;
    dispatch_once(&chatviewControlleronce, ^{
        chatviewController = [[ChatViewController alloc] init];
    });
    return chatviewController;
    
    
}
-(instancetype)init{
    
    self = [super init];
    NSLog(@"the test");
    isShowKey = NO;
    return self;
}

/*
 - (void)blockMethod:(id)sender {
 if (self) {
 if (self.block) {
 self.block(titleView.titleLab.text);
 NSLog(@"chat block.");
 //            [self dismissViewControllerAnimated:YES completion:nil];
 }
 NSLog(@"chat is click.");
 }else{
 titleView.titleLab.text = @"title";
 }
 }
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:KNOTIFICATION_onMesssageChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadMediaAttachFileCompletion:) name:KNOTIFICATION_DownloadMessageCompletion object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFileCompletion:) name:KNOTIFICATION_DownloadFileCompletion object:nil];
    NSMutableArray *mArray =[NSMutableArray array];
    mArray = [DeviceDelegateHelper sharedInstance].receiveArray;
    for (NSString *str in mArray) {
        [self addReceiveMessageWithContent:str time:nil];
        // 2、刷新表格
        [chatTableView reloadData];
        
        // 3、滚动至当前行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
        [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        // 4、清空文本框内容
        _keyBorad.sendMessageField.text = nil;
        
    }
}
-(void)viewDidLoad{
    
    [self hideTabBar]; //隐藏tabBar
    [self hideNavBar];
    
    self.view.backgroundColor = BackColor;
    
    //    TitleView* titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth,titleY+titleHeight)];
    //    [titleView.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    titleView.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //    titleView.titleLab.text = @"宋庆龄";
    //    [titleView.leftBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    titleView.backgroundColor = BackColor;
    //    [self.view addSubview:titleView];
    //    [self.view addSubview:titleView.leftBtn];
    //    [self.view insertSubview:titleView aboveSubview:chatTableView];
    
    
    
    //Back button
    //    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, titleY, UIScreenWidth*0.2, titleHeight)];
    //    [_backBtn setTitle:@"Back" forState:UIControlStateNormal];
    //    [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [_backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:_backBtn];
    //
    //    //title
    //    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, titleY, UIScreenWidth*0.3, titleHeight)];
    //    title.text = @"风度科技";
    //    title.textColor = [UIColor whiteColor];
    //    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    //    [self.view addSubview:title];
    
    
    //    ChatView* chatView = [[ChatView alloc]initWithFrame:CGRectMake(0, TitleBGHeight, UIScreenWidth , UIScreenHeight)]
    //    ;
    //    chatView.backgroundColor = BackColor;
    //    [self.view addSubview:chatView];
    
    
    //    cRV = [[ChatRecordView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight*0.78)];
    //    cRV.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    //    [chatView addSubview:cRV];
    
    //    添加键盘视图
    _keyBorad = [[KeyBoradView alloc]initWithFrame: KeyBoradNormalFrame];
    _keyBorad.backgroundColor = [UIColor clearColor];
    _keyBorad.delegate = self;
    _keyBorad.sendMessageField.delegate = self;
    _keyBorad.contentView.delegate= self;
    _keyBorad.voiceBtn.delegate = self;
    _keyBorad.picBtn.delegate = self;
    _keyBorad.faceBtn.delegate = self;
    
    
    //    player =  [[AVAudioPlayer alloc]init];
    //    player.delegate = self;
    
    //    player.delegate = self;
    
    //    keyBorad.contentView.
    //    设置textField输入起始位置
    
    //    [keyBorad.voiceBtn addTarget:self action:@selector(voicBtnByClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_keyBorad];
    
    
    //tableView begin===============************************************===============================
    /*
     chatTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, titleView.frame.origin.y+titleView.frame.size.height, UIScreenWidth, UIScreenHeight-titleHeight-keyBoradViewNormalHeight-titleY)];
     chatTableView.backgroundColor = [UIColor whiteColor];
     chatTableView.delegate = self;
     chatTableView.dataSource = self;
     [self.view addSubview:chatTableView];
     [self.view insertSubview:chatTableView belowSubview:titleView];
     */
    //tableView end===============************************************===============================
    chatTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, titleY+titleHeight, UIScreenWidth, UIScreenHeight-titleHeight-keyBoradViewNormalHeight-titleY)];
    chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    chatTableView.allowsSelection = NO;
    chatTableView.delegate = self;
    chatTableView.dataSource = self;
    chatTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    _allMessagesFrame = [NSMutableArray array];
    NSString *previousTime = nil;
    for (NSDictionary *dict in array) {
        
        MessageFrame *messageFrame = [[MessageFrame alloc] init];
        Message *message = [[Message alloc] init];
        message.dict = dict;
        message.isCurrentSend = NO; //连网测试
        messageFrame.showTime = ![previousTime isEqualToString:message.time];
        messageFrame.message = message;
        previousTime = message.time;
        
        [_allMessagesFrame addObject:messageFrame];
    }
    //    chatTableView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:chatTableView];
    
    //    sendView = [[SendMessageView alloc]initWithFrame:CGRectMake(0, cRV.frame.size.height+cRV.frame.origin.y, UIScreenWidth, UIScreenHeight*0.3)];
    //    sendView.sendMessageField.delegate = self;
    //    sendView.backgroundColor= [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    //    [chatView addSubview:sendView];
    
    //    NSNotification* notification = [NSNotification notificationWithName:kImageNotificationLoadFailed(connection.imageURL)
    //                                                                 object:self
    //                                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:error,@"error",connection.imageURL,@"imageURL",nil]];
    
    
    //    chatTableView = [UITableView alloc]initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>);
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [chatTableView addGestureRecognizer:gesture];
    //    [titleView addGestureRecognizer:gesture];
    
    
    
    //    UIButton* sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth-100, 10, 100, 100)];
    //    sendBtn.backgroundColor = [UIColor greenColor];
    //    [sendBtn addTarget:self action:@selector(sendBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:sendBtn];
    
    
    titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth,titleY+titleHeight)];
    [titleView.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    titleView.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleView.titleLab.text = _titleValue;
    [titleView.leftBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    titleView.backgroundColor = BackColor;
    [self.view addSubview:titleView];
    
    //  连网测试 begin
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(chageNetworkState) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //  连网测试 end
    
    //    UITextField
    aDelegate = [AppDelegate sharedManager];
    
    
}


//连网测试
-(void)chageNetworkState{
    
    static int clickNum = 0;
    if (clickNum % 2) {
        aDelegate.isConnectNetwrok = NO;
        NSLog(@" network state  no connect.");
    }else{
        aDelegate.isConnectNetwrok = YES;
        NSLog(@" network state yes connect .");
        
    }
    clickNum++;
}
//#pragma mark - 键盘处理
//#pragma mark 键盘即将显示
//- (void)keyBoardWillShow:(NSNotification *)note{
//
//    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat ty = - rect.size.height;
//    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
//    }];
//
//}
//#pragma mark 键盘即将退出
//- (void)keyBoardWillHide:(NSNotification *)note{
//
//    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//        self.view.transform = CGAffineTransformIdentity;
//    }];
//}
#pragma chatVoiceBtnDelegate
-(BOOL)voicBtnByClicked{
    NSLog(@"testthe voiceBtn.");
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{       // return NO to disallow editing.
    NSLog(@"test aaaaa");
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //    float width = self.view.frame.size.width;
    //    float height = self.view.frame.size.height;
    //上移30个单位，按实际情况设置
    //    CGRect rect=CGRectMake(0.0f,-30,width,height);
    //    sendView.frame=rect;
    _keyBorad.frame = KeyBoradTextSelectedFrame;
    chatTableView.frame = contentViewTextSelectFrame;
    [UIView commitAnimations];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    return YES;
}
#pragma chatContentTableView begin
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //tableView begin===============************************************===============================
    /*
     //指定cellIdentifier为自定义的cell
     static NSString *CellIdentifier = @"writeCell";
     //自定义cell类
     ChatEachWritingCell *cell = (ChatEachWritingCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"ChatEachOtherCell" owner:self options:nil];
     
     for (id oneObject in nib) {
     if ([oneObject isKindOfClass:[ChatEachWritingCell class]]) {
     cell = [oneObject initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     }
     
     cell.writeContentLab.text = @"hello . what are you doing?";
     cell.writeContentLab.lineBreakMode = UILineBreakModeWordWrap;
     cell.writeContentLab.numberOfLines = 0;//注意：此处表示所有文字全部显示行数不固定。
     cell.timeLab.text= @"12:00";
     cell.textAlignment = NSTextAlignmentLeft;
     cell.perImg.image = [UIImage imageNamed:@"1.jpg"];
     return cell;
     
     */
    //tableView end===============************************************===============================
    //    static NSString *CellIdentifier = @"Cell";
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // 设置数据
        cell.delegate = self;
    }
    cell.messageFrame = _allMessagesFrame[indexPath.row];
    
    //    NSLog(@"messageFrame:%@",((MessageFrame*)_allMessagesFrame[indexPath.row]).message.image);
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMessagesFrame.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_allMessagesFrame[indexPath.row] cellHeight];
}
//#pragma sendBtn addTalkData
//-(void)sendBtn:(id)sender{
//
//    [self addTalkData];
//}

-(void)addTalkData{
    // 1、增加数据源
    
    NSString *content = _keyBorad.sendMessageField.text;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    [self addMessageWithContent:content time:time];
    // 2、刷新表格
    [chatTableView reloadData];
    
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _keyBorad.sendMessageField.text = nil;
}


-(void)sendMessage
{
    NSString * textString = _keyBorad.sendMessageField.text;
    if (textString.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"不能发送空白消息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    NSString * to =@"88750900000016";
    //loginInfo.username = @"88750900000016";
    //loginInfo.username = @"88750900000045";
    ECMessage* message = [[DeviceChatHelper sharedInstance] sendTextMessage:textString to:to];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onMesssageChanged object:message];
    
}
#pragma mark 给数据源增加内容
//text by add
- (void)addMessageWithContent:(NSString *)content time:(NSString *)time{
    
    NSLog(@"test %@",content);
    if (content.length == 0) {
        return;
    }
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content = content;
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeMe;
    msg.showType = MessageShowTypeText;
    msg.isCurrentSend = YES; //连网测试
    mf.message = msg;
    
    [_allMessagesFrame addObject:mf];
}
- (void)addReceiveMessageWithContent:(NSString *)content time:(NSString *)time{
    
    NSLog(@"test %@",content);
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content = content;
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeOther;
    msg.showType = MessageShowTypeText;
    msg.isCurrentSend = YES; //连网测试
    mf.message = msg;
    
    [_allMessagesFrame addObject:mf];
}


//img by add
-(void)addReceiveMessageWithImg:(NSData *)data time:(NSString *)time
{
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    //    msg.content =content;
    //    msg.content = @"biaoQing1.png";
    msg.imageData = [data copy];
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeOther;
    msg.showType = MessageShowTypeData;
    //    msg.voicePath = voicePath;
    msg.isCurrentSend = YES; //连网测试
    mf.message = msg;
    NSLog(@"message is :%@",mf.message.content);
    [_allMessagesFrame addObject:mf];
    NSLog(@"mf:%@",_allMessagesFrame);
    
}
- (void)addMessageWithImg:(NSString *)content time:(NSString *)time{
    
    NSLog(@"test content:%@",content);
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content =content;
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeMe;
    msg.showType = MessageShowTypeImg;
    msg.isCurrentSend = YES; //连网测试
    
    mf.message = msg;
    NSLog(@"message is :%@",mf.message.content);
    [_allMessagesFrame addObject:mf];
    NSLog(@"mf:%@",_allMessagesFrame);
}

//voiceImgMsg by add
- (void)addReceiveMessageWithImg:(NSString *)content andVoice:(NSURL*)voicePath time:(NSString *)time
{
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content =content;
    //    msg.content = @"biaoQing1.png";
    
    
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeOther;
    msg.showType = MessageShowTypeImageAndVoice;
    msg.voicePath = voicePath;
    msg.isCurrentSend = YES; //连网测试
    mf.message = msg;
    NSLog(@"message is :%@",mf.message.content);
    [_allMessagesFrame addObject:mf];
    NSLog(@"mf:%@",_allMessagesFrame);
    
}
- (void)addMessageWithImg:(NSString *)content andVoice:(NSURL*)voicePath time:(NSString *)time{
    
    NSLog(@"test content:%@",content);
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content =content;
    //    msg.content = @"biaoQing1.png";
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeMe;
    msg.showType = MessageShowTypeImgVoice;
    msg.voicePath = voicePath;
    msg.isCurrentSend = YES; //连网测试
    mf.message = msg;
    NSLog(@"message is :%@",mf.message.content);
    [_allMessagesFrame addObject:mf];
    NSLog(@"mf:%@",_allMessagesFrame);
}

-(void)addMessageWithImage:(UIImage *)img andVoice:(NSURL*)voicePath time:(NSString *)time{
    //    NSLog(@"test content:%@",content);
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    
    msg.image = img;
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeMe;
    msg.showType = MessageShowTypeImgVoiceByUIIMG;
    msg.voicePath = voicePath;
    msg.isCurrentSend = YES; //连网测试
    mf.message = msg;
    NSLog(@"message is :%@",mf.message.content);
    [_allMessagesFrame addObject:mf];
    NSLog(@"mf:%@",_allMessagesFrame);
}

- (void)addMessageWithData:(NSData*)data time:(NSString *)time dataType:(DataType)dataType{
    
    //    UIImageView* imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    //    imgV.image = [UIImage imageWithData:data];
    //    [self.view addSubview:imgV];
    
    //    NSLog(@"test content:%@",content);
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    //    msg.content =content;
    //    msg.content = @"biaoQing1.png";
    msg.imageData = [data copy];
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeMe;
    msg.showType = MessageShowTypeData;
    //    msg.voicePath = voicePath;
    msg.isCurrentSend = YES; //连网测试
    mf.message = msg;
    NSLog(@"message is :%@",mf.message.content);
    [_allMessagesFrame addObject:mf];
    NSLog(@"mf:%@",_allMessagesFrame);
}

-(void)addMessageWithImg:(UIImage*)img withMultChatObj:(MultChatObj*)multCO withTime:(NSString*)time{
    
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    //    msg.content =content;
    //    msg.content = @"biaoQing1.png";
    //    msg.imageData = [data copy];
    msg.time = time;
    msg.icon = @"1.jpg";
    msg.type = MessageTypeMe;
    msg.showType = MessageShowTypeMultChatImg;
    //    msg.voicePath = voicePath;
    msg.image = img;
    msg.mCObj = multCO;
    msg.isCurrentSend = YES; //连网测试
    mf.message = msg;
    NSLog(@"message is :%@",mf.message.content);
    [_allMessagesFrame addObject:mf];
    NSLog(@"mf:%@",_allMessagesFrame);
    
}



#pragma chatContentTableView end

#pragma gesture (触摸取消键盘)
//隐藏键盘的方法
-(void)hidenKeyboard
{
    NSLog(@"hidenKeyboard");
    [self resumeView];
}

#pragma gesture end
//隐藏键盘的方法
//-(void)hidenKeyboard
//{
//    NSLog(@"hidenKeyboard");
//    [sendView.sendMessageField resignFirstResponder];
//    [self resumeView];
//}

#pragma mark - UITextField代理
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSLog(@"test.");
//    /*
//    NSDictionary *jackey = [NSDictionary dictionaryWithObjectsAndKeys:
//                            textField.text,@"content",
//                            @"jackey",@"name",
//                            @"NoRecord",@"recordFile",
//                            nil];
//    [self.sumChat addObject:jackey];
//
//    //为了清除之前的回答数据，在这里释放_data，不然每次alloc会有不同地址造成内存泄露。
//    [_data release];
//    _data = nil;
//    _data = [[NSMutableData alloc]init];
//
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://dev.skjqr.com/api/weixin.php?email=5914018@qq.com&appkey=d5fa0a17b4bb12838b9a0e57a34edc17&msg=%@",textField.text]];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
//
//    [NSURLConnection connectionWithRequest:request delegate:self];
//    [request release];
//
//    [self.chatTableView reloadData];
//
//    if (self.sumChat.count >1) {
//        [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.sumChat.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }
//
//    textField.text = nil;
//    //    [textField resignFirstResponder];
//    return YES;
//     */
//    return YES;
//}

//恢复原始视图位置
-(void)resumeView
{
    [_keyBorad.sendMessageField resignFirstResponder];
    NSLog(@"resumeView...");
    CGRect rect=KeyBoradNormalFrame;
    _keyBorad.frame=rect;
    chatTableView.frame =contentViewNormalFrame;
    //    -(void)changeImg:(ButtonState)keyBoradState;
    [_keyBorad changeImg:button_state_none
     ];
    //    [keyBorad cl];
}



#pragma voiceBtnClick===begin
#pragma textView =======


- (BOOL)textFiledShouldBeginEditing:(UITextField *)textView{
    NSLog(@"lingkangli.....");
    //     sendView.frame= CGRectMake(0, UIScreenHeight*0.48, UIScreenWidth, UIScreenHeight*0.7);
    //    return YES;
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //    float width = self.view.frame.size.width;
    //    float height = self.view.frame.size.height;
    //上移30个单位，按实际情况设置
    //    CGRect rect=CGRectMake(0.0f,-30,width,height);
    //    sendView.frame=rect;
    _keyBorad.frame = KeyBoradSelectedFrame;
    chatTableView.frame = contentViewSelectFrame;
    [UIView commitAnimations];
    //    [chatTableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    return YES;
}

#pragma mark 点击textField键盘的回车按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendMessage];
    [self addTalkData];
    return YES;
    
}

-(BOOL)textView:(UITextField *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"test");
    return YES;
}

#pragma voiceBtnClick===begin

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //    sendView.frame = CGRectMake(0, cRV.frame.size.height+cRV.frame.origin.y, UIScreenWidth, UIScreenHeight*0.3);
    //    //当textField不再是第一监听者时键盘关闭
    //    [sendView.sendMessageField resignFirstResponder];
    //    [sendView.expressionBtn setImage:[UIImage imageNamed:@"face.png"] forState:UIControlStateNormal];
}

-(void)backBtn:(id) sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self showTabBar];
}

#pragma     keyBoradSelected    [self.delegate keyBoradSelected];
-(void)keyBoradState:(ButtonState)state{
    
    
    if (state == KeyBoradContentState_none) {
        NSLog(@"keyborad...none");
        chatTableView.frame =contentViewNormalFrame;
        
        //        [sendView.sendMessageField resignFirstResponder];
    }else if(state == KeyBoradContentState_Emoji || state == KeyBoradContentState_Pic || state == KeyBoradContentState_voice){
        
        NSLog(@"keyborad...have");
        chatTableView.frame =contentViewSelectFrame;
        //        lingkangli add
        // 3、滚动至当前行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
        [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    NSLog(@"state : %i",state);
}

-(void)testLog:(UIButton *)delegateButton{
    NSLog(@"log..%i",delegateButton.tag);
}

//从moveBtn处传到keyborad传到此处的uiimage.
-(void)keyBoradPic:(NSString *)filePath2{
    //    [self addMessageWithContent:filePath time:(NSString *)];
    
    NSLog(@"comehere : %@",filePath2);
    NSString *content =filePath2;
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    //    用对象mainBundle获取图片路径
    
    NSString *imagePath = [mainBundle pathForResource:content ofType:nil];
    NSLog(@"图片的路径%@",imagePath);
    
    NSString * to =@"88750900000016";
    //loginInfo.username = @"88750900000016";
    //loginInfo.username = @"88750900000045";
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    [self addMessageWithImg:content time:time];
    [[DeviceChatHelper sharedInstance] sendimageMessage:imagePath displayName:content to:to];
    // 2、刷新表格
    [chatTableView reloadData];
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _keyBorad.sendMessageField.text = nil;
}

-(void)keyBoradPicForData:(NSData*)data ForType:(DataType)dataType{
    
    if (dataType == DataTypeImg) {
        
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        NSDate *date = [NSDate date];
        
        fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
        NSString *time = [fmt stringFromDate:date];
        NSString * to =@"88750900000016";
        //先把图片转成NSData
        
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        _filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        [[DeviceChatHelper sharedInstance] sendimageMessage:_filePath displayName:nil to:to];
        NSLog(@"图片路径%@",_filePath);
        [self addMessageWithData:data time:time dataType:dataType];
        
        // 2、刷新表格
        [chatTableView reloadData];
        // 3、滚动至当前行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
        [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        //        UIImageView* imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        //        imgV.image = [UIImage imageWithData:data];
        //        [self.view addSubview:imgV];
    }
}


//delegate
//发送图片和声音
#pragma mark 发送图片和声音
-(void)keyBoradPic:(NSString *)filePath andVoicePath:(NSURL *)voicePath{
    
    NSLog(@"comehere : %@",filePath);
    NSString *content =filePath;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"yyyyMMddHHmmss"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    //    用对象mainBundle获取图片路径
    
    NSString *imagePath = [mainBundle pathForResource:content ofType:nil];
    NSLog(@"图片的路径%@",imagePath);
    NSLog(@"声音的路径%@",voicePath);
    //把voicePath 转成str
    NSString *str = [[voicePath absoluteString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *voiceStr = [NSMutableString stringWithString:str];
    [voiceStr deleteCharactersInRange:NSMakeRange(0, voiceStr.length - 30)];
    NSLog(@"%@",voiceStr);
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docspath = [paths objectAtIndex:0];
    
    
    //写入imageData
    NSString *imageDataPath=[NSString stringWithFormat:@"%@/%@",docspath,content];
    [fileManager fileExistsAtPath:imageDataPath];
    NSLog(@"%@",imageDataPath);
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    [imageData writeToFile:imageDataPath atomically:YES];
    //写入VoiceData
    NSString *voiceDataPath = [NSString stringWithFormat:@"%@/%@",docspath,voiceStr];
    [fileManager fileExistsAtPath:voiceDataPath];
    NSData *voiceData = [NSData dataWithContentsOfURL:voicePath];
    [voiceData writeToFile:voiceDataPath atomically:YES];
    
    //创建压缩文件
    NSString *zipFile = [docspath stringByAppendingPathComponent:@"data.zip"];
    ZipArchive *za =[[ZipArchive alloc]init];
    [za CreateZipFile2:zipFile];
    [za addFileToZip:imageDataPath newname:content];
    [za addFileToZip:voiceDataPath newname:voiceStr];
    [za CloseZipFile2];
    NSLog(@"压缩包----》%@",zipFile);
    //压缩完删掉
    [fileManager removeItemAtPath:imageDataPath error:nil];
    [fileManager removeItemAtPath:voiceDataPath error:nil];
    NSString *to=@"88750900000016";
    [[DeviceChatHelper sharedInstance] sendFileMessage:zipFile displayname:nil to:to];
    
    
    
    //    [self addMessageWithImg:content time:time];
    
    
    //    - (void)addMessageWithImg:(NSString *)content andVoice:(NSURL*)voicePath time:(NSString *)time{
    
    [self addMessageWithImg:filePath andVoice:voicePath time:time];
    // 2、刷新表格
    [chatTableView reloadData];
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _keyBorad.sendMessageField.text = nil;
    //
    //    UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    img.image = [UIImage imageNamed:@"biaoQing1.png"];
    //    [[[UIApplication sharedApplication]keyWindow] addSubview:img];
    
}


-(void)keyBoradPick:(NSString *)filePath andVoicePath:(NSURL *)voicePath{
    
    NSLog(@"comehere : %@",filePath);
    NSString *content =filePath;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    
    
    //    [self addMessageWithImg:content time:time];
    
    //    - (void)addMessageWithImg:(NSString *)content andVoice:(NSURL*)voicePath time:(NSString *)time{
    
    [self addMessageWithImg:filePath andVoice:voicePath time:time];
    // 2、刷新表格
    [chatTableView reloadData];
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _keyBorad.sendMessageField.text = nil;
    //
    //    UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    img.image = [UIImage imageNamed:@"biaoQing1.png"];
    //    [[[UIApplication sharedApplication]keyWindow] addSubview:img];
    
}

-(void)keyBoradPicWithImg:(UIImage*)image andVoicePath:(NSURL*)filePath2{
    
    //    NSLog(@"comehere : %@",filePath);
    //    NSString *content =filePath;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    //    [self addMessageWithImg:content time:time];
    //    - (void)addMessageWithImg:(NSString *)content andVoice:(NSURL*)voicePath time:(NSString *)time{
    //    [self addMessageWithImg:filePath andVoice:filePath2 time:time];
    
    [self addMessageWithImage:image andVoice:filePath2 time:time];
    
    // 2、刷新表格
    [chatTableView reloadData];
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _keyBorad.sendMessageField.text = nil;
    //
    //    UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    img.image = [UIImage imageNamed:@"biaoQing1.png"];
    //    [[[UIApplication sharedApplication]keyWindow] addSubview:img];
}

//MultChatObjDelegate from keyborad
-(void)keyBoradPicWithImg:(UIImage*)img withMultObj:(MultChatObj*)mcObj{
    
    NSLog(@"keyBorad %@",mcObj);
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    //    [self addMessageWithImg:content time:time];
    //    - (void)addMessageWithImg:(NSString *)content andVoice:(NSURL*)voicePath time:(NSString *)time{
    //    [self addMessageWithImg:filePath andVoice:filePath2 time:time];
    
    //    [self addMessageWithImage:img andVoice:filePath2 time:time];
    //    -(void)addMessageWithImg:(UIImage*)img withMultChatObj:(MultChatObj*)multCO withTime:(NSString*)time{
    [self addMessageWithImg:img withMultChatObj:mcObj withTime:time];
    
    // 2、刷新表格
    [chatTableView reloadData];
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _keyBorad.sendMessageField.text = nil;
    
    //    NSLog(@"keyBoradDelegate...sucess .it is in ChatViewController.");
}

//MultChatObjDelegate from chatView => chatView
-(void)backFontPageImg:(UIImage*)img WithMultObj:(MultChatObj*)multChO{
    NSLog(@"keyBorad %@",multChO);
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    //    [self addMessageWithImg:content time:time];
    //    - (void)addMessageWithImg:(NSString *)content andVoice:(NSURL*)voicePath time:(NSString *)time{
    //    [self addMessageWithImg:filePath andVoice:filePath2 time:time];
    
    //    [self addMessageWithImage:img andVoice:filePath2 time:time];
    //    -(void)addMessageWithImg:(UIImage*)img withMultChatObj:(MultChatObj*)multCO withTime:(NSString*)time{
    [self addMessageWithImg:img withMultChatObj:multChO withTime:time];
    
    // 2、刷新表格
    [chatTableView reloadData];
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _keyBorad.sendMessageField.text = nil;
    
    //    NSLog(@"keyBoradDelegate...sucess .it is in ChatViewController.");
    
}

-(void)moveButtonState:(NSString *)state{
    
    [_keyBorad.sendMessageField resignFirstResponder];
    NSLog(@"resumeView...");
    CGRect rect=KeyBoradNormalFrame;
    _keyBorad.frame=rect;
    chatTableView.frame =contentViewNormalFrame;
    
    NSLog(@"change..");
}

-(void)playTheVoice:(NSURL *)url{
    
    //    NSLog(@"the url voice:%@",url);
    //    player = [player initWithContentsOfURL:url error:nil];
    ////    [player url:url];
    //    [player prepareToPlay];
    //    [player play];
    
}
//显示收到的文字

-(void)refreshTableView:(NSNotification*)notification{
    
    NSMutableArray *mArray =[NSMutableArray array];
    mArray = [DeviceDelegateHelper sharedInstance].onReceiveArray;
    for (NSString *str in mArray) {
        [self addReceiveMessageWithContent:str time:nil];
        // 2、刷新表格
        [chatTableView reloadData];
        
        // 3、滚动至当前行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
        [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        // 4、清空文本框内容
        _keyBorad.sendMessageField.text = nil;
        
    }
    [mArray removeAllObjects];
}

//显示收到图片
-(void)downloadMediaAttachFileCompletion:(NSNotification *)notification
{
    NSMutableArray *mArray =[NSMutableArray array];
    mArray = [DeviceDelegateHelper sharedInstance].imageArray;
    for (NSString *str in mArray) {
        
        NSLog(@"图片地址%@",str);
        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
        
        
        
        
        [self addReceiveMessageWithImg:imageData time:nil];
        // 2、刷新表格
        [chatTableView reloadData];
        
        // 3、滚动至当前行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
        [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        // 4、清空文本框内容
        _keyBorad.sendMessageField.text = nil;
        
    }
    
    [mArray removeAllObjects];
    
    
    NSLog(@"收到图片");
    
}
//收到的图片和声音
-(void)downloadFileCompletion:(NSNotification *)notification
{
    
    NSString *imagePath = notification.userInfo[@"image"];
    NSString *voicePath = notification.userInfo[@"voice"];

//      NSString *voicePath = @"/Users/feixuan/Library/Developer/CoreSimulator/Devices/92F7E569-E142-48D6-864C-5C3B26185E4E/data/Containers/Data/Application/22A16A66-6A51-435D-B940-A6A1BB206D3B/Library/Caches/Cachestmp20150831161458001.aac";
    NSString *str = [NSString stringWithFormat:@"file://%@",voicePath];

    NSURL*voiceUrl = [NSURL URLWithString:str];
    
    [self addReceiveMessageWithImg:imagePath andVoice:voiceUrl time:nil];
    
    // 2、刷新表格
    [chatTableView reloadData];
    
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _keyBorad.sendMessageField.text = nil;
    
}







@end
