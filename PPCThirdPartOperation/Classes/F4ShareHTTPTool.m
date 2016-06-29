//
//  F4ShareNetworkTool.m
//  shareDemo
//
//  Created by Ryan on 15/7/17.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "F4ShareHTTPTool.h"
#import "AFHTTPSessionManager.h"
#import "F4ShareUserInfo.h"

@implementation F4ShareHTTPTool
singleton_implementation(F4ShareHTTPTool)

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailBlock)fail
{
//    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
//    
//    [manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]])
//        {
//            F4ShareUserInfo *userInfo = [F4ShareUserInfo weiBoUserInfoWithJson:responseObject];
//            if (success)
//            {
//                success(userInfo);
//            }
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (error)
//        {
//            if (fail)
//            {
//                fail(error);
//            }
//        }
//    }];
}


@end
