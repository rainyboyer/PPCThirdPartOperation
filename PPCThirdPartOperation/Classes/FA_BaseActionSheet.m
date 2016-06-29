//
//  FA_BaseActionSheet.m
//  F4App
//
//  Created by Apple on 4/27/15.
//  Copyright (c) 2015 iOS Team. All rights reserved.
//

#import "FA_BaseActionSheet.h"
#import "F4HandleEngine.h"
#import "PodAsset.h"

#define MainRect [[UIScreen mainScreen] bounds]
#define HeightInterval 10.0
#define ButtonHeight 90.0
#define LogoImageSize CGSizeMake(45, 45)
@interface FA_BaseActionSheet()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGFloat actionHeight;

@end
@implementation FA_BaseActionSheet

- (instancetype)initWithTitles:(NSArray *)titles
{
    
    self = [super initWithFrame:MainRect];
    if (self)
    {
        self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5f];
        self.actionHeight = titles.count <= 0? 54: ((titles.count-1)/4 +1)*ButtonHeight +54;
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, MainRect.size.height, MainRect.size.width, _actionHeight)];
        _bgView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
        [self addSubview:_bgView];
        
        CGFloat buttonWidth = self.frame.size.width/4;
        for (int i = 0; i< titles.count; i++)
        {
            NSString *title = [[F4HandleEngine sharedInstance] getPlatformNameWith:[[titles objectAtIndex:i] intValue]];
            NSString *logoName = [[F4HandleEngine sharedInstance] getPlatformImageNameWith:[[titles objectAtIndex:i] intValue]];
            NSData *logoData = [PodAsset dataForFilename:[logoName stringByAppendingPathExtension:@"png"]
                                                     pod:@"PPCThirdPartOperation"];
            
            UIImage *logoImage = [self imageByScalingAndCroppingForSize:LogoImageSize
                                                            sourceImage:[UIImage imageWithData:logoData]];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake((i%4)* buttonWidth, (i/4)*ButtonHeight, buttonWidth, ButtonHeight)];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [button setTitle:title forState:UIControlStateNormal];
            [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button setImage:logoImage forState:UIControlStateNormal];
            
            CGFloat offset = 20.0f;
            button.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                      -button.imageView.frame.size.width,
                                                      -button.imageView.frame.size.height-offset/2,
                                                      0);
            button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height-offset/2,
                                                      0,
                                                      0,
                                                      -button.titleLabel.intrinsicContentSize.width);
            [button setTag:[[titles objectAtIndex:i] intValue]];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_bgView addSubview:button];
            
//            // 竖线
//            UIView *vLineView = [[UIView alloc]initWithFrame:CGRectMake(((i+1)%4)* buttonWidth -0.5,
//                                                                        (i/4)*ButtonHeight,
//                                                                        0.5,
//                                                                        ButtonHeight)];
//            vLineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
//            [_bgView addSubview:vLineView];
            // 横线
            UIView *hLineView = [[UIView alloc]initWithFrame:CGRectMake((i%4)* buttonWidth,
                                                                        ((i/4)+1)*ButtonHeight-0.5,
                                                                        buttonWidth,
                                                                        0.5)];
            hLineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
            [_bgView addSubview:hLineView];
        }
        UIView *intervalView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                       ((titles.count-1)/4 +1)*ButtonHeight,
                                                                       MainRect.size.width,
                                                                       HeightInterval)];
        intervalView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5f];
        [_bgView addSubview:intervalView];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(0,
                                          intervalView.frame.size.height +intervalView.frame.origin.y,
                                          MainRect.size.width,
                                          44.0f)];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor whiteColor]];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [cancelButton addTarget:self
                         action:@selector(cancelButtonPressed)
               forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:cancelButton];
        
        [UIView animateWithDuration:0.2f animations:^{
            _bgView.frame = CGRectMake(0, MainRect.size.height- _actionHeight, MainRect.size.width, _actionHeight);
        }];
        
        // 移除ActionSheet手势
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(cancelButtonPressed)];
        tapGestureRecognizer.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

#pragma mark - Private Methods
// 分享按键点击
- (void)buttonPressed:(UIButton *)btn
{
    void (^shareResult)(NSInteger,NSString *) = ^(NSInteger stateCode , NSString *stateString)
    {
        NSLog(@"ShareResult: %zd \n stateString = %@", stateCode,stateString);
    };
    [[F4HandleEngine sharedInstance] shareTo:(SharePlatform)btn.tag message:_message result:shareResult];
    [self cancelButtonPressed];
}

// 取消按钮点击
- (void)cancelButtonPressed
{
    [UIView animateWithDuration:0.2f animations:^{
        _bgView.frame = CGRectMake(0, MainRect.size.height, MainRect.size.width, _actionHeight);
        [self performSelector:@selector(backgroundViewRemove) withObject:nil afterDelay:0.2];
    }];
    
}

// 移除灰色背景
- (void)backgroundViewRemove
{
    [self removeFromSuperview];
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize sourceImage:(UIImage *)image
{
    UIImage *newImage = nil;
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [image drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
@end
