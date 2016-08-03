//
//  UIImage+Zhangwenybx.m
//  乐攒
//
//  Created by 天问科技 on 14-11-21.
//  Copyright (c) 2014年 Zhangwenybx. All rights reserved.
//

#import "UIImage+Zhangwenybx.h"

@implementation UIImage (Zhangwenybx)

- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height
{
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:1.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

- (UIImage *)makeStretchableFlatRight
{
    CGSize size = self.size;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1, 1.0f, (size.width-3))
    resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)makeStretchableFlatLeft
{
    CGSize size = self.size;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, (size.width-3), 1.0f, 1)
                                resizingMode:UIImageResizingModeStretch];
}

@end
