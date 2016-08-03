//
//  LoginController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : BaseController
{
    UITextField * textField;
    
    UIButton * _currentSelectButton;
    
    UILabel * _sliderLable;
    
    UIButton *_verifyCodeButton;

}


/** 手机号输入框*/
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UIImageView * phoneImage;



/** 密码输入框*/
@property (nonatomic, strong) UITextField * passwordTextField;
@property (nonatomic, strong) UIImageView * passwordImage;




@end
