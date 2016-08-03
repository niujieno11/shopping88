//
//  FindPWSetPWController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"

@interface FindPWSetPWController : BaseController

/** 手机号输入框*/
@property (nonatomic, weak) UITextField * nwePWTextField;

/** 验证码输入框*/
@property (nonatomic, weak) UITextField * beSurePWTextField;

@property (nonatomic, copy) NSString * phoneNum;

@property (nonatomic, copy) NSString * code;

@end
