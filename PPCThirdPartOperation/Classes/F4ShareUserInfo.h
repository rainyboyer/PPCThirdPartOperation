//
//  F4ShareUserInfo.h
//  shareDemo
//
//  Created by Ryan on 15/7/17.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface F4ShareUserInfo : NSObject

@property (nonatomic, copy) NSString *nickName; /**< 昵称 */
@property (nonatomic, copy) NSString *gender;   /**< 性别 */
@property (nonatomic, copy) NSString *iconUrl;  /**< 头像 */
@property (nonatomic, copy) NSString *location; /**< 地区 */
@property (nonatomic, copy) NSString *platformUserID; /**< 平台用户ID */
@property (nonatomic, copy) NSString *platformName; /**< 平台名字 */

/**
 *  传递微博授权登录的Json字典,返回用户信息模型
 *
 *  @param dict Json字典
 *
 *  @return 用户信息模型
 */
+ (instancetype)weiBoUserInfoWithJson:(NSDictionary *)dict;
/**
 *  传递QQ授权登录的Json字典,返回用户信息模型
 *
 *  @param dict Json字典
 *
 *  @return 用户信息模型
 */
+ (instancetype)qqUserInfoWithJson:(NSDictionary *)dict;


@end
