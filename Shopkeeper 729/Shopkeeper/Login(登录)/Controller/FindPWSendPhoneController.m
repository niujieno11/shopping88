//
//  FindPWSendPhoneController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "FindPWSendPhoneController.h"
#import "FindPWSetPWController.h"

@interface FindPWSendPhoneController ()

@end

@implementation FindPWSendPhoneController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGBCOLOR(245, 245, 245)];
    
    [self createNavbar];
    
    [self createUi];
    
}

-(void)createNavbar
{
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 64)];
    [navView setBackgroundColor:KMainColor];
    [self.view addSubview:navView];
    
    //2.登录按钮
    UIButton * backbButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 24, 60, 40)];
    [backbButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbButton addTarget:self action:@selector(backbButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [backbButton setBackgroundColor:[UIColor blueColor]];
    [backbButton setImageEdgeInsets:UIEdgeInsetsMake(7, 17, 7, 17)];
    [self.view addSubview:backbButton];

    
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-50, 35, 100, 20)];
    [titleLable setText:@"找回密码"];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont systemFontOfSize:15]];
    [titleLable setTextAlignment:1];
    [navView addSubview:titleLable];
}

-(void)backbButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createUi
{
    NSArray * arr = @[@"请输入手机号", @"请输入登录密码"];
    NSArray * nameArr = @[@"gphone", @"gsuo"];
    
    //1.输入框及背景
    for (int i = 0; i < 2; i++) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-140, 120+i*70, 280, 50)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [bgView.layer setCornerRadius:5];
        [bgView.layer setBorderColor:RGBCOLOR(235, 235, 235).CGColor];
        [bgView.layer setBorderWidth:1];
        
        [self.view addSubview:bgView];
        
        UIImageView * image = [[UIImageView alloc]init];
//        [image setBackgroundColor:[UIColor redColor]];
        if (i == 0) {
            [image setFrame:CGRectMake(15, 15, 14, 20)];
            
        }else {
            [image setFrame:CGRectMake(15, 15, 15, 20)];
        }
        [image setImage:[UIImage imageNamed:nameArr[i]]];
        [bgView addSubview:image];
        
        UITextField * textField = [[UITextField alloc]init];
        [textField setTextColor:[UIColor grayColor]];
        [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [textField setFont:[UIFont systemFontOfSize:14]];
        [textField setPlaceholder:arr[i]];
//        [textField setBackgroundColor:[UIColor redColor]];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        [self.view addSubview:textField];
        if (i == 0) {
            _phoneTextField = textField;
            [_phoneTextField setFrame:CGRectMake(Main_Screen_Width/2-100, 120+i*70, 210, 50)];
        }else {
            _codeTextField = textField;
            [_codeTextField setFrame:CGRectMake(Main_Screen_Width/2-100, 120+i*70, 140, 50)];

            // .发送验证码按钮
            _verifyCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(280-101, 0, 100, 50)];
            [_verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_verifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_verifyCodeButton.layer setCornerRadius:5];
            [_verifyCodeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
            [_verifyCodeButton setBackgroundColor:KMainColor];
            [_verifyCodeButton addTarget:self action:@selector(senderVerifyCode) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:_verifyCodeButton];
        }
    }
    
    //2.登录按钮
    UIButton * loginButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-140, 270, 280, 46)];
    [loginButton setBackgroundColor:KMainColor];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"下一步" forState:UIControlStateNormal];
    [loginButton.layer setCornerRadius:4];
    [loginButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

-(void)nextButtonAction
{
    if (_codeTextField.text.length == 0) {
        [self createAlertView:@"请输入验证码"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 1.手机号码
    [dic setObject:_phoneTextField.text forKey:@"mobile"];
    
    [dic setObject:_codeTextField.text forKey:@"smscode"];
    
    [dic setObject:@"code" forKey:@"m"];
    
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kFindPW Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kFindPW == %@",dic);
        if ([dic objectForKey:@"errcode"]) {
            if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
                
                FindPWSetPWController * set = [[FindPWSetPWController alloc]init];
                set.phoneNum =  _phoneTextField.text;
                set.code =  _codeTextField.text;
                [self.navigationController pushViewController:set  animated:YES];
                
            }
        }
       
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}


#pragma mark - 发送验证码
- (void)senderVerifyCode
{
    //    NSLog(@"[_phoneNumTextField.text length] == %d",[_phoneNumTextField.text length]);
    if ([_phoneTextField.text length] != 11) {
        [self createAlertView:@"请输入正确的手机号"];
        return;
    }
    
    [self yourButtonTitleTime];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 1.手机号码
    [dic setObject:_phoneTextField.text forKey:@"mobile"];
    
    [dic setObject:@"sms" forKey:@"m"];

    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kFindPW Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kFindPW == %@",dic);
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"发送成功！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        
    }];

    
}

#pragma mark - 倒计时
- (void)yourButtonTitleTime
{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //
                [_verifyCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                _verifyCodeButton.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [_verifyCodeButton setTitle:[NSString stringWithFormat:@"%@秒后发送",strTime] forState:UIControlStateNormal];
                _verifyCodeButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}




@end
