//
//  NSDictionary+URLQuery.h
//  F4App
//
//  Created by Apple on 6/12/15.
//  Copyright (c) 2015 iOS Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(URLQuery)
+ (instancetype)dealWithQueryWithMask:(NSString *)mask;
@end
