//
//  DisregistrationController.h
//  Shopkeeper
//
//  Created by TianView on 16/7/8.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TWUser;
@interface DisregistrationController : UIViewController
{
    UIView * paddingView1;
    UIView * paddingView2;
    UIView * paddingView3;
    UITextField * iphoneField;
    UITextField * passwordField;
    // UITextField * code;
    UIButton * nextButton;
    UIImageView * imageview;
    UIImageView * imageviewPass;
    UIButton * getCodeButton;
}
@property (nonatomic,strong)TWUser * user;


@end
