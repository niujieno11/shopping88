//
//  ShopButton.m
//  HonGuMircoShop
//
//  Created by 张耀文 on 15/9/11.
//  Copyright (c) 2015年 张耀文. All rights reserved.
//

#import "ShopButton.h"

@implementation ShopButton




- (id)initWithFrame:(CGRect)frame ImageSize:(CGSize)imageSize ImageProportion:(CGFloat)imageProportion TextFontSize:(NSInteger)textFontSize TextProportion:(CGFloat)textProportion;
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageSize = imageSize;
        _imageProportion = imageProportion;
        _textProportion = textProportion;
        [self.titleLabel setTextAlignment:1];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:KGlobalCOLOR_A forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:textFontSize]];
     }
    return self;
}


#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width/2-(_imageSize.width/2), contentRect.size.height*_imageProportion, _imageSize.width, _imageSize.height);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height*_textProportion, contentRect.size.width, 15);
}

@end
