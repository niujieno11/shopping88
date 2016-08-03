//
//  FindPWSendPhoneController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPWSendPhoneController : BaseController
{
    UIButton *_verifyCodeButton;

}
/** 手机号输入框*/
@property (nonatomic, weak) UITextField * phoneTextField;

/** 验证码输入框*/
@property (nonatomic, weak) UITextField * codeTextField;

@end
