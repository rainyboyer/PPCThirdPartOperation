//
//  FA_BaseActionSheet.h
//  F4App
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F4ShareMessage.h"
@interface FA_BaseActionSheet : UIView
@property (nonatomic, strong) F4ShareMessage *message;

- (instancetype)initWithTitles:(NSArray *)titles;

@end
