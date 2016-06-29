//
//  F4ShareProtocol.h
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F4ShareMessage.h"

@protocol F4HandleProtocol <NSObject>

// 支持分享平台
- (NSNumber *)supportedSharePlatform;

@optional
// 处理分享内容
- (BOOL)handleMessage:(F4ShareMessage *)message result:(ShareResult)result;

// 平台登录账号
- (BOOL)userLoginResult:(LoginResult)result;

// 处理回调
- (BOOL)handleWithSourceApplication:(NSString *)application url:(NSURL *)url;

// 设置微信平台
- (BOOL)registerPlatformWithAppID:(NSString *)appID redirectURI:(NSString *)redirectURI;

/**<获取平台名字*/
- (NSString *)getPlatformName;

/**<获取平台logo名字*/
- (NSString *)getPlatformImageName;
@end
