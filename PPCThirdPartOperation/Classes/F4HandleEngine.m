//
//  F4ShareEngine.m
//  F4Share
//
//  Created by Apple on 7/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "F4HandleEngine.h"
#import "F4QQHandler.h"

@interface F4HandleEngine()
@property (nonatomic, strong) NSMutableDictionary *mapping;
@end
@implementation F4HandleEngine

singleton_implementation(F4HandleEngine);

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _mapping = [[NSMutableDictionary alloc]init];
    }
    return self;
}

#pragma mark - Public Methods
- (BOOL)shareTo:(SharePlatform)platform message:(F4ShareMessage *)message result:(ShareResult)result
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        return NO;
    }
    
    return [handler handleMessage:message result:result];
}

- (BOOL)loginWith:(SharePlatform)platform result:(LoginResult)result
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        return NO;
    }
    
    return [handler userLoginResult:result];
}

- (void)register:(id<F4HandleProtocol>)platform
{
    NSNumber *key = [self generateKeyWithPlatform:platform];
    _mapping[key] = platform;
}

- (BOOL)registerWith:(SharePlatform)platform appID:(NSString *)appID redirectURI:(NSString *)redirectURI
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        return NO;
    }
    
    return [handler registerPlatformWithAppID:appID redirectURI:redirectURI];
}

- (NSString *)getPlatformNameWith:(SharePlatform)platform
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        NSLog(@"抱歉，不支持此平台");
        return nil;
    }
    
    return [handler getPlatformName];
}

- (NSString *)getPlatformImageNameWith:(SharePlatform)platform
{
    NSNumber *key = [NSNumber numberWithInt:platform];
    id <F4HandleProtocol> handler = _mapping[key];
    if (handler == nil)
    {
        return nil;
    }
    
    return [handler getPlatformImageName];
}

#pragma mark - Private Methods
- (NSNumber *)generateKeyWithPlatform:(id <F4HandleProtocol>)platform
{
    return platform.supportedSharePlatform;
}

- (BOOL)handleWithSourceApplication:(NSString *)application openURL:(NSURL *)url
{
    BOOL success = NO;
    for (NSNumber *key in _mapping)
    {
        if (key)
        {
            id <F4HandleProtocol> handler = _mapping[key];
            success = [handler handleWithSourceApplication:application url:url];
            if (success)
            {
                return success;
            }
        }
    }
    return success;
}
@end
