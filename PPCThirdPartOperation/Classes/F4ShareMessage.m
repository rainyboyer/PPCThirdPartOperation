//
//  F4ShareMessage.m
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "F4ShareMessage.h"

@implementation F4ShareMessage
-(BOOL)isEmpty:(NSArray*)emptyValueForKeys AndNotEmpty:(NSArray*)notEmptyValueForKeys{
    @try {
        if (emptyValueForKeys) {
            for (NSString *key in emptyValueForKeys) {
                if ([self valueForKeyPath:key]) {
                    return NO;
                }
            }
        }
        if (notEmptyValueForKeys) {
            for (NSString *key in notEmptyValueForKeys) {
                if (![self valueForKey:key]) {
                    return NO;
                }
            }
        }
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"isEmpty error:\n %@",exception);
        return NO;
    }
}
@end
