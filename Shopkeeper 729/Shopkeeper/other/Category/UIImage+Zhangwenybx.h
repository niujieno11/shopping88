//
//  UIImage+Zhangwenybx.h
//  乐攒
//
//  Created by 天问科技 on 14-11-21.
//  Copyright (c) 2014年 Zhangwenybx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Zhangwenybx)

- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

- (UIImage *)makeStretchableFlatRight;
- (UIImage *)makeStretchableFlatLeft;
@end
