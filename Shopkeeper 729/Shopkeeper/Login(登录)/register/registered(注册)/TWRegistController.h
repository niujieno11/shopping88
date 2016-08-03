//
//  TWRegistController.h
//  TWCompare
//
//  Created by TianView on 16/6/15.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWUser;
@interface TWRegistController : BaseController<UIAlertViewDelegate>
{
    UIView * paddingView1;//偏移量
    UIView * paddingView2;//偏移量
    UIView * paddingView3;//偏移量
    UITextField * iphoneField; //手机号
    UITextField * passwordField;//验证码
   // UITextField * code;
    UIButton * nextButton;
    UIImageView * imageview;
    UIImageView * imageviewPass;
    UIButton * getCodeButton;
    
    UITextField * userNameText;  //用户名
    UIView * userNamePaddingView;
    UIImageView * userImage;
    
    UITextField * passwordTextField;//密码
    UIView * passwordView;
    UIImageView * passwordImage;
    
    UITextField * passOnceWoreTextField;
    UIView * passOnceView;
    UIImageView * passWordOnceImage;
    

    
    UILabel * label;
    UIView *  navView;
    
    UIImageView * im;
    UIImageView * im1;
    UIImageView * im2;
    
    UILabel * zhanghao;
    UILabel * zhiliao;
    UILabel * renzheng;
    UILabel * pay;
    
    UIView * backView;
    
}
@property (nonatomic,strong)TWUser * user;
@property (nonatomic,copy)NSString * story_id_2; //parent_ids
@property (nonatomic,copy)NSString * storetype;
@end
