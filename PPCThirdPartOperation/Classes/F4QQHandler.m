//
//  F4ShareQQHandler.m
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "F4QQHandler.h"
#import "F4HandleEngine.h"
#import "F4ShareUserInfo.h"
#import "NSDictionary+URLQuery.h"
#import <UIKit/UIKit.h>

@interface F4QQHandler()
@property (nonatomic, strong) TencentOAuth *tencent;
@property (nonatomic, copy) ShareResult shareResult;
@property (nonatomic, copy) LoginResult loginResult;
@property (nonatomic, copy) NSString *stateString;
@end
@implementation F4QQHandler

- (void)load
{
    [[F4HandleEngine sharedInstance] register:(id <F4HandleProtocol>)self];
}

- (NSNumber *)supportedSharePlatform
{
    return [NSNumber numberWithInt:SharePlatformQQ];
}

- (NSString *)getPlatformName
{
    return @"QQ";
}

- (NSString *)getPlatformImageName
{
    return @"img_icon_qq";
}

#pragma mark - F4HandleProtocol
//  赋值用户登录结果
- (BOOL)userLoginResult:(LoginResult)result
{
    //用户权限
    NSArray *permissions = @[@"get_user_info", @"add_share"];
    [_tencent authorize:permissions inSafari:NO];
    _loginResult = result;
    return YES;
}

//  注册腾讯APPid和跳转URL
- (BOOL)registerPlatformWithAppID:(NSString *)appID redirectURI:(NSString *)redirectURI
{
    self.tencent = [[TencentOAuth alloc]initWithAppId:appID andDelegate:self];
    _tencent.redirectURI = redirectURI;
    _tencent.sessionDelegate = self;
    return YES;
}

#pragma mark - TencentSession Delegate
// 登录失败
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"登录失败");
}

// 连接网络失败
- (void)tencentDidNotNetWork
{
    NSLog(@"连接网络失败");
}

// 登录成功
- (void)tencentDidLogin
{
    NSLog(@"登录成功");
    BOOL result = [_tencent getUserInfo];
    if (!result)
    {
        NSLog(@"获取用户信息失败");
    }
}

// 获取用户信息
- (void)getUserInfoResponse:(APIResponse *)response
{
    F4ShareUserInfo *userInfo = [F4ShareUserInfo qqUserInfoWithJson:response.jsonResponse];
    userInfo.platformUserID = [_tencent openId];
    [self handleSendResult:response.detailRetCode];
    _loginResult(userInfo, response.detailRetCode, _stateString);
}

#pragma mark - TencentShare
// 设置分享配置
- (BOOL)handleMessage:(F4ShareMessage *)message result:(ShareResult)result
{
    self.shareResult = result;
    id apiObject = [self setApiObjectWithMessage:message];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:apiObject];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];

    return YES;
}

// 设置分享对象
- (id)setApiObjectWithMessage:(F4ShareMessage *)message
{
    __block id apiObject = nil;
    if (message.shareType == ShareImage)// 分享图片
    {
        if (message.imageUrl == nil)
        {
            NSLog(@"您的分享图片为空或未能解析");
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:message.imageUrl]];
            apiObject = [QQApiImageObject objectWithData:imageData
                                        previewImageData:imageData
                                                   title:message.title.length? message.title: @"分享图片"
                                             description:message.desc.length? message.desc: @"图片详情"];
        }
    }
    else if (message.shareType == ShareText)
    {
        if (message.desc == nil)
        {
            NSLog(@"您的分享文字为空");
        }
        else
        {
            apiObject = [QQApiTextObject objectWithText:message.desc? message.desc: @"分享"];
        }
    }
    else if (message.shareType == ShareVideo)// 分享视频
    {
        if (message.mediaDataUrl == nil)
        {
            NSLog(@"您的视频网址尚未设置");
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:message.imageUrl]];
            apiObject = [QQApiVideoObject objectWithURL:[NSURL URLWithString:message.mediaDataUrl]
                                                  title:message.title.length? message.title: @"分享视频"
                                            description:message.desc.length? message.desc: @"视频详情"
                                       previewImageData:imageData? imageData: nil];
        }
    }
    else if (message.shareType == ShareNews)// 分享新闻
    {
        if (message.url == nil)
        {
             NSLog(@"您的分享网址尚未设置");
        }
        else
        {
            apiObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:message.url]
                                                 title:message.title.length? message.title: @"分享"
                                           description:message.desc.length? message.desc: @"详情"
                                       previewImageURL:message.imageUrl.length?
                                                        [NSURL URLWithString:message.imageUrl]: nil];
        }
    }
    else// 分享其他类型
    {
        NSLog(@"QQ不支持此分享类型");
    }
    return apiObject;
}

//  处理结果
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPISENDSUCESS:
        {
            _stateString = @"登录成功";
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            _stateString = @"未安装手机QQ";
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            _stateString = @"API接口不支持";
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            _stateString = @"发送参数错误";
            break;
        }
        case EQQAPIAPPNOTREGISTED:
        {
            _stateString = @"App未注册";
            break;
        }
        case EQQAPISENDFAILD:
        {
            _stateString = @"发送失败";
            break;
        }
        case EQQAPIAPPSHAREASYNC:
        {
            _stateString = @"分享";
            break;
        }
    }

}

// QQ应用的反馈信息
- (BOOL)handleWithSourceApplication:(NSString *)application url:(NSURL *)url
{
    if ([application isEqualToString:@"com.tencent.mqq"])
    {
        NSLog(@"QQ反馈");
        NSMutableDictionary *dic = [NSMutableDictionary dealWithQueryWithMask:url.absoluteString];
        NSEnumerator * enumeratorKey = [dic keyEnumerator];
        
        //快速枚举遍历所有KEY的值
        for (NSString *object in enumeratorKey)
        {
            if ([object isEqualToString:@"error"])
            {
                NSInteger errorCode = [[dic objectForKey:@"error"] integerValue];
                _shareResult(errorCode, errorCode != 0? @"操作失败": @"操作成功");
            }
        }

        
        [TencentOAuth HandleOpenURL:url];
        return YES;
    }
    else
    {
        return NO;
    }

}

@end
