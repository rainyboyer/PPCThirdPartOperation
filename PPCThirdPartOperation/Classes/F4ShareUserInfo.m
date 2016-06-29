//
//  F4ShareUserInfo.m
//  shareDemo
//
//  Created by Ryan on 15/7/17.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "F4ShareUserInfo.h"

@implementation F4ShareUserInfo
/**
 *  传递微博授权登录的Json字典,返回用户信息模型
 *
 *  @param dict Json字典
 *
 *  @return 用户信息模型
 */
+ (instancetype)weiBoUserInfoWithJson:(NSDictionary *)dict
{
    F4ShareUserInfo *userInfo = [[F4ShareUserInfo alloc] init];
    userInfo.nickName = dict[@"screen_name"];
    userInfo.iconUrl  = dict[@"avatar_large"];
    userInfo.gender   = dict[@"gender"];
    userInfo.location = dict[@"location"];
    userInfo.platformUserID = dict[@"idstr"];
    userInfo.platformName = @"Weibo";
    return userInfo;
}

/**
 *  传递QQ授权登录的Json字典,返回用户信息模型
 *
 *  @param dict Json字典
 *
 *  @return 用户信息模型
 */
+ (instancetype)qqUserInfoWithJson:(NSDictionary *)dict
{
    NSLog(@"QQ dict: %@", dict);
    F4ShareUserInfo *userInfo = [[F4ShareUserInfo alloc] init];
    userInfo.nickName = dict[@"nickname"];
    userInfo.iconUrl  = dict[@"figureurl_qq_2"];
    userInfo.gender   = dict[@"gender"];
    userInfo.location = [NSString stringWithFormat:@"%@ %@",dict[@"city"],dict[@"province"]];
    userInfo.platformName = @"QQ";
    return userInfo;
}

@end
