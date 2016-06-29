//
//  NSDictionary+URLQuery.m
//  F4App
//
//  Created by Apple on 6/12/15.
//  Copyright (c) 2015 iOS Team. All rights reserved.
//

#import "NSDictionary+URLQuery.h"

@implementation NSMutableDictionary(URLQuery)
+ (NSMutableDictionary *)dealWithQueryWithMask:(NSString *)mask
{
    NSArray *strings = [mask componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for (NSString *string in strings)
    {
        NSArray *temp = [string componentsSeparatedByString:@"="];
        [dic setObject:[temp objectAtIndex:1] forKey:[temp objectAtIndex:0]];
    }
    return dic;
}
@end
