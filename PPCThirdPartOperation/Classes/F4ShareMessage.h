//
//  F4ShareMessage.h
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F4ShareUserInfo.h"
typedef enum {
    ShareNone, /**<不分享*/
    ShareText, /**<文字*/
    ShareImage, /**<图片*/
    ShareNews, /**<新闻&&网址*/
    ShareMusic, /**<音频*/
    ShareVideo, /**<视频*/
    ShareApp, /**<应用*/
    ShareNonGif, /**<无GIF消息*/
    ShareGif /**<带GIF消息*/
}ShareType;


typedef enum {
    SharePlatformQQ,  /**<QQ好友&QQ空间*/
    SharePlatformWeibo, /**<新浪微博*/
    SharePlatformWeChat, /**<微信好友*/
    SharePlatformTimeline /**<微信朋友圈*/
}SharePlatform;



typedef void(^ShareResult)(NSInteger stateCode,NSString *stateString);                             /**<分享结果*/
typedef void(^LoginResult)(F4ShareUserInfo *userInfo, NSInteger stateCode , NSString *stateString);/**<授权登录结果*/

@interface F4ShareMessage : NSObject
// ID
@property (nonatomic, assign) int tid;
// 分享标题
@property (nonatomic, strong) NSString *title;
// 分享描述
@property (nonatomic, strong) NSString *desc;
// 分享URL
@property (nonatomic, strong) NSString *url;
// 分享ImageURL
@property (nonatomic, strong) NSString *imageUrl;
// 分享缩略图URL
@property (nonatomic, strong) NSString *thumbnailUrl;
// 分享图片ImageData
@property (nonatomic, strong) NSData *shareImageData;
// 分享类型
@property (nonatomic, assign) ShareType shareType;
// 分享音乐类型
@property (nonatomic, strong) NSString *musicUrl;
// 分享扩展信息
@property (nonatomic, strong) NSString *extInfo;
// 分享视频数据URL
@property (nonatomic, strong) NSString *mediaDataUrl;
// 文件扩展
@property (nonatomic, strong) NSString *fileExt;

- (BOOL)isEmpty:(NSArray*)emptyValueForKeys AndNotEmpty:(NSArray*)notEmptyValueForKeys;

@end
