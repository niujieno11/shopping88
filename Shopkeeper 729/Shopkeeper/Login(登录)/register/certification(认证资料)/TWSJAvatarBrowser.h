//
//  TWSJAvatarBrowser.h
//  TWCompare
//
//  Created by TianView on 16/6/30.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TWSJAvatarBrowser : NSObject

@property (nonatomic,strong)UIImage * brief; //浏览头像
@property (nonatomic,strong)UIImageView * oldImageView;//头像所在的imageView



+(void)showImage:(UIImageView*)avatarImageView;
+(void)hideImage:(UITapGestureRecognizer*)tap;
@end
