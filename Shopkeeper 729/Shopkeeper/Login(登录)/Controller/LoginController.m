//
//  LoginController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "LoginController.h"
#import "FindPWSendPhoneController.h"
#import "ZYWNavigationController.h"
#import "HomeController.h"
#import "UserDataModel.h"
#import "TWRegistController.h"
#import "TWInformationController.h"
#import "TWCerController.h"
#import "TWServiceController.h"
#import "TWSweepController.h"
#import "Masonry.h"
#import "TWAgreeController.h"
#import "TWOpenController.h"
#import "TWSubmitController.h"

@interface LoginController ()

@end

@implementation LoginController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
   
}
- (void)notfication{
 
    // LoginController * login = [[LoginController alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    

    //获取通知中心 传手机号
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    
    //添加观察者
    [center addObserver:self selector:@selector(reciveNotic:) name:@"notic" object:nil];
    
    
    //1.背景图
    [self createBackImage];

    [self createUi];
}
//观察者监听手机号
- (void)reciveNotic:(NSNotification *)notification{

    self.phoneTextField.text = [notification.userInfo objectForKey:@"text"];
    
    NSLog(@"self.phoneTextField.text:%@",self.phoneTextField.text);
    
}

-(void)createBackImage
{
    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [bgImage setImage:[UIImage imageNamed:@"login_bg"]];
    [self.view addSubview:bgImage];
}


-(void)createUi
{
    NSArray * nameArr1 = @[@"短信验证码绑定", @"用户名密码绑定"];
    for (int i = 0; i < nameArr1.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/nameArr1.count*i, 80, Main_Screen_Width/nameArr1.count, 50)];
        [button setTitle:nameArr1[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:RGBACOLOR(255, 255, 255, 0.5) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(transactionBtAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.view addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _currentSelectButton = button;
        }
        
        UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80+i*50, Main_Screen_Width, 0.5)];
        [lineLable setBackgroundColor:RGBACOLOR(255, 255, 255, 0.5)];
        [self .view addSubview:lineLable];
        
    }
    
    _sliderLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 129, Main_Screen_Width/2, 2)];
    [_sliderLable setBackgroundColor:[UIColor whiteColor]];
    [self .view addSubview:_sliderLable];
    
    
    //0. 搜一扫
    //3.找回密码
    UIButton * saoButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-100, 30, 80, 44)];
    //    [saoButton setBackgroundColor:[UIColor redColor]];
    [saoButton addTarget:self action:@selector(saoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saoButton];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 50, 44)];
    [lable setText:@"扫一扫"];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setFont:[UIFont systemFontOfSize:15]];
    [saoButton addSubview:lable];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 13, 17, 17)];
    [image setImage:[UIImage imageNamed:@"sao"]];
    [saoButton addSubview:image];
    
    
    NSArray * arr = @[@"请输入手机号", @"请输入验证码"];
    NSArray * nameArr = @[@"phone", @"suo"];
    
    //1.输入框及背景
    for (int i = 0; i < 2; i++) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(40, 184+i*70, Main_Screen_Width-80, 50)];
        [bgView setBackgroundColor:RGBACOLOR(250, 250, 250, 0.4)];
        [bgView.layer setCornerRadius:5];
        [self.view addSubview:bgView];
        
        UIImageView * image = [[UIImageView alloc]init];
        if (i == 0) {
            [image setFrame:CGRectMake(15, 14, 15, 22)];
            _phoneImage = image;
            
        }else {
            [image setFrame:CGRectMake(15, 13, 17, 23)];
            _passwordImage = image;
        }
        [image setImage:[UIImage imageNamed:nameArr[i]]];
        [bgView addSubview:image];
        
        textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 185+i*70, (Main_Screen_Width-60-70), 50)];
        //        [textField setBackgroundColor:[UIColor greenColor]];
        [textField setPlaceholder:arr[i]];
        [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        [textField setTextColor:[UIColor whiteColor]];
        
        //关闭联想及首字母大写功能
        [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [textField setFont:[UIFont systemFontOfSize:12]];
        [self.view addSubview:textField];
        if (i == 0) {
            _phoneTextField = textField;
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }else {
            textField.secureTextEntry = YES;
            _passwordTextField = textField;
            [_passwordTextField setFrame:CGRectMake(80, 185+i*70, (Main_Screen_Width-60-170), 50)];
        }
    }
    
    
    // .发送验证码按钮
    _verifyCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-131, 185+70, 90, 48)];
    [_verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_verifyCodeButton.layer setCornerRadius:5];
    [_verifyCodeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [_verifyCodeButton setBackgroundColor:KMainColor];
    [_verifyCodeButton addTarget:self action:@selector(senderVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verifyCodeButton];
    
    //2.登录按钮
    UIButton * loginButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 350, Main_Screen_Width-80, 47)];
    [loginButton setBackgroundColor:[UIColor whiteColor]];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [loginButton setTitleColor:KMainColor forState:UIControlStateNormal];
    [loginButton setTitle:@"登   录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAcion) forControlEvents:UIControlEventTouchUpInside];
    [loginButton.layer setCornerRadius:4];
    [self.view addSubview:loginButton];
    
    //3.注册
    UIButton * registerButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-150, 420, 70, 44)];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"我要开店" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];

    
    //4.找回密码
    UIButton * findPWButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2+70, 420, 80, 44)];
    [findPWButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [findPWButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [findPWButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPWButton addTarget:self action:@selector(findPWButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPWButton];
}


-(void)transactionBtAction:(UIButton *)bt
{
    _currentSelectButton.selected = NO;
    bt.selected = YES;
    _currentSelectButton = bt;
    
    [_phoneTextField resignFirstResponder];
    
    if ([bt.titleLabel.text isEqualToString:@"短信验证码绑定"]) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_sliderLable setFrame: CGRectMake(0, 129, Main_Screen_Width/2, 2)];
            
        } completion:^(BOOL finished) {
            
        }];
        _phoneTextField.placeholder = @"请输入手机号";
        _passwordTextField.placeholder =@"请输入验证码";
        _verifyCodeButton.hidden = NO;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        
    }else {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_sliderLable setFrame: CGRectMake(Main_Screen_Width/2, 129, Main_Screen_Width/2, 2)];
        } completion:^(BOOL finished) {
            
        }];
        _phoneTextField.placeholder = @"请输入用户名";
        _passwordTextField.placeholder =@"请输入登录密码";
        _verifyCodeButton.hidden = YES;
        _phoneTextField.keyboardType = UIKeyboardTypeDefault;
        
    }
    
    _phoneTextField.text = @"";
    _passwordTextField.text =@"";
    
}

// - 发送验证码
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
    
    [dic setObject:@"code" forKey:@"m"];
    
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kLogin Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kLogin_senderVerifyCode == %@",dic);
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


-(void)loginButtonAcion
{
        _phoneTextField.text = @"牵守.在一起";
        _passwordTextField.text = @"123456";
//        _phoneTextField.text = @"18213561340";
//        _passwordTextField.text = @"38500";
//    
    if ([_phoneTextField.text length] ==0) {
        if ([_currentSelectButton.titleLabel.text isEqualToString:@"短信验证码绑定"]) {
            [self createAlertView:@"请输入手机号"];
            
        }else {
            [self createAlertView:@"请输入用户名"];
        }
        
        
        return;
    }else if ([_passwordTextField.text length] ==0) {
        if ([_currentSelectButton.titleLabel.text isEqualToString:@"短信验证码绑定"]) {
            [self createAlertView:@"请输入短信验证码"];
            
        }else {
            [self createAlertView:@"请输入密码"];
        }
        
        return;
    }
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    if ([_currentSelectButton.titleLabel.text isEqualToString:@"短信验证码绑定"]) {
        [dic setObject:_phoneTextField.text forKey:@"mobile"];
        [dic setObject:_passwordTextField.text forKey:@"code"];
        
    }else {
        
        [dic setObject:[_phoneTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"member_name"];
        [dic setObject:_passwordTextField.text forKey:@"password"];
        [dic setObject:@"member" forKey:@"m"];
    }
    

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"登录中...";
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kLogin Parameters:dic style:kConnectGetType success:^(id dic) {
        NSLog(@"kLogin == %@", dic);
        NSLog(@"1111");
        NSString * errcodeStr = [NSString stringWithFormat:@"%@",dic[@"errcode"]];
        if ([errcodeStr isEqualToString:@"0"]) {
            
            [self writeUserDicToFileWithUserDic:[dic objectForKey:@"data"]];
            
            UserDataModel * userModel = [UserInfo shareUserInfoSingleton].userDataModel;
NSLog(@"1112");
            if ([userModel.flag isEqualToString:@"11"] && [userModel.store_type isEqualToString:@"1"] && [userModel.is_guarantee isEqualToString:@"0"] ) {
                TWInformationController *  TWInformation = [[TWInformationController alloc]init];
                
                [self.navigationController pushViewController:TWInformation animated:YES];
            }else if ([userModel.flag isEqualToString:@"12"] && [userModel.store_type isEqualToString:@"1"] && [userModel.is_guarantee isEqualToString:@"0"]) {
                TWCerController * TWCer= [[TWCerController alloc]init];
               NSLog(@"1113");
                [self.navigationController pushViewController:TWCer animated:YES];
            }else if ([userModel.flag isEqualToString:@"1"] && [userModel.store_type isEqualToString:@"1"] && [userModel.is_guarantee isEqualToString:@"0"]){
//                HomeController * home = [[HomeController alloc]init];
//                [self.navigationController pushViewController:home animated:YES];
                TWServiceController *server = [[TWServiceController alloc]init];
                
                [self.navigationController pushViewController:server animated:YES];
                
                
            }else if ([userModel.flag isEqualToString:@"1"] && [userModel.store_type isEqualToString:@"1"] && [userModel.is_guarantee isEqualToString:@"1"]){
                
                HomeController * home = [[HomeController alloc]init];
                [self.navigationController pushViewController:home animated:YES];
                
            }else if([userModel.flag isEqualToString:@"11"] && [userModel.store_type isEqualToString:@"2"]){
                
                
                TWInformationController *  TWInformation = [[TWInformationController alloc]init];
                
                [self.navigationController pushViewController:TWInformation animated:YES];
                
            
            }else if([userModel.flag isEqualToString:@"12"] && [userModel.store_type isEqualToString:@"2"]){
                
                TWCerController * TWCer= [[TWCerController alloc]init];
                
                [self.navigationController pushViewController:TWCer animated:YES];
            
            }else if ([userModel.flag isEqualToString:@"1"] && [userModel.store_type isEqualToString:@"2"] ){

                HomeController * home = [[HomeController alloc]init];
                [self.navigationController pushViewController:home animated:YES];
               
            }
        }else {
            [self createAlertView:@"账号或密码错误"];
        }
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([error isKindOfClass:[NSString class]]) {
            [self createAlertView:@"网络连接异常"];

        }else {
            NSLog(@"error -- %@",error);

        }
    }];
    
}

-(void)writeUserDicToFileWithUserDic:(NSDictionary *)userDic
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [userDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *str = [NSString stringWithFormat:@"%@",obj];
        if (![str isEqualToString:@"<null>"]) {
            [dict setObject:obj forKey:key];
        }
    }];
    //        NSLog(@"dict == %@",dict);
    [UserInfo shareUserInfoSingleton].userDataModel = [UserDataModel objectWithKeyValues:userDic];
    [UserInfo shareUserInfoSingleton].userInfoDic = dict;
//    NSLog(@"[UserInfo shareUserInfoSingleton].userInfoDic == %@",[UserInfo shareUserInfoSingleton].userInfoDic);
    
}

-(void)findPWButtonAction
{
    [self.navigationController pushViewController:[[FindPWSendPhoneController alloc]init] animated:YES];
}

-(void)registerButtonAction
{
    [self.navigationController pushViewController:[[TWAgreeController alloc]init] animated:YES];
}

-(void)saoButtonAction
{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *altC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查设备相机!" preferredStyle:UIAlertControllerStyleAlert];
        [altC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:altC animated:YES completion:nil];
        return;
        
    }else{
        
       [self.navigationController pushViewController:[[TWSweepController alloc]init] animated:YES];
        
    }

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}
//移除通知
- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notic" object:nil];
    
}

@end
