//
//  F4ShareQQHandler.h
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F4HandleProtocol.h"
#import "TencentOAuth.h"
#import "QQApiInterfaceObject.h"
#import "QQApiInterface.h"
#import "TencentApiInterface.h"
@interface F4QQHandler : NSObject<F4HandleProtocol, TencentSessionDelegate>

- (void)load;
/**<注册tencentAPI*/
- (BOOL)registerPlatformWithAppID:(NSString *)appID redirectURI:(NSString *)redirectURI;
/**<tencent登录*/
- (BOOL)userLoginResult:(LoginResult)result;
/**<tencent分享*/
- (BOOL)handleMessage:(F4ShareMessage *)message result:(ShareResult)result;
@end
