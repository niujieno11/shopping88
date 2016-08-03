//
//  ShopButton.h
//  HonGuMircoShop
//
//  Created by 张耀文 on 15/9/11.
//  Copyright (c) 2015年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopButton : UIButton
{
    CGSize  _imageSize;
    CGFloat _imageProportion;
    CGFloat _textProportion;

}

- (id)initWithFrame:(CGRect)frame ImageSize:(CGSize)imageSize ImageProportion:(CGFloat)imageProportion TextFontSize:(NSInteger)textFontSize TextProportion:(CGFloat)textProportion;

@end
