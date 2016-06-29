//
//  F4ShareNetworkTool.h
//  shareDemo
//
//  Created by Ryan on 15/7/17.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class F4ShareUserInfo;

typedef void(^SuccessBlock)(F4ShareUserInfo *userInfo);
typedef void(^FailBlock)(NSError *error);

@interface F4ShareHTTPTool : NSObject
singleton_interface(F4ShareHTTPTool)

/**
 *  封装AFN的网络处理方法
 *
 *  @param url     url
 *  @param params  字典参数
 *  @param success 成功时返回的Block
 *  @param fail    失败的block
 */
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailBlock)fail;


@end
