//
//  PPCViewController.m
//  PPCThirdPartOperation
//
//  Created by Pen on 06/13/2016.
//  Copyright (c) 2016 Pen. All rights reserved.
//

#import "PPCViewController.h"
#import "FA_BaseActionSheet.h"
#import "F4QQHandler.h"

@interface PPCViewController ()
@property (nonatomic, strong) F4QQHandler *qqHandler;
@end

@implementation PPCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 100.0f, self.view.frame.size.width, 100.0f)];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, loginButton.frame.origin.y+ loginButton.frame.size.height, self.view.frame.size.width, 100.0f)];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];

    [self initHandler];

    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initHandler
{
    self.qqHandler = [[F4QQHandler alloc]init];
    [_qqHandler load];
    [_qqHandler registerPlatformWithAppID:@"222222" redirectURI:@"www.qq.com"];
}

- (void)loginButtonClicked:(UIButton *)button
{
    void (^result)(F4ShareUserInfo *, NSInteger , NSString *) = ^(F4ShareUserInfo *userInfo, NSInteger stateCode , NSString *stateString)
    {
        NSLog(@"userInfo: %@, code: %zd, string: %@", userInfo, stateCode, stateString);
    };
    [_qqHandler userLoginResult:result];
}

- (void)shareButtonClicked:(UIButton *)button
{

//    void (^result)(NSInteger, NSString *) = ^(NSInteger stateCode, NSString *stateString)
//    {
//        NSLog(@"shareStateCode: %zd, stateString: %@", stateCode, stateString);
//    };
    F4ShareMessage *message = [[F4ShareMessage alloc]init];
    message.shareType = ShareNews;
    message.title = @"分享";
    message.imageUrl = @"http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg";
    message.desc = @"这是测试分享的描述";
    message.url = @"www.baidu.com";
    message.thumbnailUrl = @"http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg";
    
    FA_BaseActionSheet *actionSheet = [[FA_BaseActionSheet alloc]initWithTitles:@[@"QQ"]];
    actionSheet.message = message;
    [self.view addSubview:actionSheet];
//    [_qqHandler handleMessage:message result:result];
}

@end
