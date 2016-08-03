//
//  DisregistrationController.m
//  Shopkeeper
//
//  Created by TianView on 16/7/8.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "DisregistrationController.h"
#import "TWRegistController.h"
#import "Masonry.h"
#import "TWPwdController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

#import "AppDelegate.h"
#import "TWUser.h"

#import "LoginController.h"



#define HUD_SIZE CGSizeMake(150, 50)

@interface DisregistrationController ()<UITextFieldDelegate>
{
    UILabel *successAlert;
}
@property (nonatomic,strong)AFHTTPSessionManager * sessionManager;
@property (nonatomic,strong)NSArray * array;

@property (nonatomic,strong)NSArray * codeArray;

@end

@implementation DisregistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [NSArray new];
    self.codeArray = [NSArray new];
    
    [self setTextField];
    
    self.view.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];
    
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    view.frame= CGRectMake(0, 20, self.view.frame.size.width, 44);
    
    [self.view addSubview:view];
    
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];
    
    
    //计时器button
    [getCodeButton addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
    


}



//设置手机号密码输入框
- (void)setTextField{
    
    iphoneField = [[UITextField alloc]init];
    
    iphoneField.placeholder=@"请输入手机号码";
    iphoneField.font = [UIFont systemFontOfSize:14];
    iphoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    iphoneField.borderStyle = UITextBorderStyleRoundedRect;
    iphoneField.keyboardType = UIKeyboardTypeNumberPad;
    // iphoneField.text = iphoneNameText;
    [self.view addSubview:iphoneField];
    
    
    //手机号偏移量
    paddingView1 =[[UIView alloc]init];
    iphoneField.leftView = paddingView1;
    iphoneField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:paddingView1];
    
    
    //手机号图标
    imageview = [[UIImageView alloc]init];
    UIImage * img = [UIImage imageNamed:@"gphone"];
    imageview.image = img;
    
    [paddingView1 addSubview:imageview];
    
    
    
    //手机号图标适配
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.size.mas_equalTo(CGSizeMake(20, 30));
        make.top.mas_equalTo(self.view.mas_top).offset(90);
    }];
    
    //手机号偏移量适配
    [paddingView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.mas_equalTo(self.view.mas_top).offset(85);
        
    }];
    
    //短信验证码
    passwordField = [[UITextField alloc]init];
    
    passwordField.placeholder=@"请输入短信验证码";
    passwordField.font = [UIFont systemFontOfSize:14];
    // passwordField.secureTextEntry = YES;
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    
    passwordField.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview:passwordField];
    
    //获取验证码
    getCodeButton = [[UIButton alloc]init];
    getCodeButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [getCodeButton addTarget:self action:@selector(GetCode:) forControlEvents:UIControlEventTouchUpInside];
    getCodeButton.layer.cornerRadius = 5;
    
    [self.view addSubview:getCodeButton];
    
    //获取验证码适配
    [getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width / 3, 46));
        make.top.mas_equalTo(self.view.mas_top).offset(142);
        
    }];
    
    
    
    //验证码偏移量
    paddingView2 =[[UIView alloc]init];
    passwordField.leftView = paddingView2;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:paddingView2];
    
    
    //验证码图标
    imageviewPass = [[UIImageView alloc]init];
    UIImage * img1 = [UIImage imageNamed:@"gsuo"];
    imageviewPass.image = img1;
    
    [paddingView2 addSubview:imageviewPass];
    
    
    
    //验证码图标适配
    [imageviewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.size.mas_equalTo(CGSizeMake(20, 30));
        make.top.mas_equalTo(self.view.mas_top).offset(110);
    }];
    
    
    //验证码偏移量适配
    [paddingView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.mas_equalTo(self.view.mas_top).offset(105);
        
    }];
    
    
    //下一步
    nextButton = [[UIButton alloc]init];
    nextButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(ReturnNextController:) forControlEvents:UIControlEventTouchUpInside];
    
    nextButton.layer.cornerRadius = 10;
    
    
    [self.view addSubview:nextButton];
    
    //手机号适配
    [iphoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.centerX.equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-40, 50));
        
    }];
    
    //验证码适配
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).offset(140);
        make.centerX.equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-40, 50));
        
    }];
    
    //下一步适配
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).offset(220);
        make.centerX.equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-40, 50));
    }];
    
    
}

#pragma mark ------- 获取验证码按钮 判断errcode 如果为0则填验证码进行下一步注册 如果不为0则返回主页面进行登录操作 -------
- (void)GetCode:(id)sender{
    
    if ([iphoneField.text isEqualToString:@""]) {
        
    }else if (![self checkTel:iphoneField.text]){
        
    }else{
        NSString * msg = [NSString stringWithFormat:@"我们已将短信验证码发送至:%@",iphoneField.text];
        UIAlertController * a = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString * mobile = iphoneField.text;
            
            NSString * strUrl  = [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_register.html?m=vercode&mobile=%@",mobile];
            
            NSLog(@"url:%@",strUrl);
            NSString * str = [NSString stringWithFormat:@"mobile=%@",mobile];
            
            
            //网络请求相关
            self.sessionManager  = [AFHTTPSessionManager manager];
            
            self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
            
            [self.sessionManager GET:strUrl parameters:str progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary * dd =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                //  NSArray *rray = dd[@"errcode"];
                NSArray * array = dd[@"errmsg"];
                NSArray * dataArray = dd[@"data"];
                
                NSString * errmsgstr = [NSString stringWithFormat:@"%@",array];
                
                NSString * msgData = [NSString stringWithFormat:@"%@",dataArray];
                
                NSLog(@"errmsgstr:%@",errmsgstr);
                
                if ([dd[@"errcode"]  isEqual:@"1"]) {
                    
                    UIAlertController * a = [UIAlertController alertControllerWithTitle:@"温馨提示" message:errmsgstr preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //填写验证码进行下一步注册的走的方法

                        
                        LoginController * login = [[LoginController alloc]init];
                        
                        [self.navigationController pushViewController:login animated:YES];
                    }];
                    
                    [a addAction:act];
                    
                    [self presentViewController:a animated:YES completion:nil];
                    
                }
                
                if (dd[@"data"] != nil){
                    
                    UIAlertController * a = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msgData preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //在这里直接跳转到登录页面的方法
                        NSLog(@"跳转登录页面走的方法");
                        
                    }];
                    
                    [a addAction:act];
                    
                    [self presentViewController:a animated:YES completion:nil];
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error:%@",error);
            }];
        }];
        
        
        [a addAction:act1];
        
        [self presentViewController:a animated:YES completion:nil];
    }
    
}

#define  mark ----------  获取验证码倒计时 ----------
- (void)startTime{
    
    [self checkTel:iphoneField.text];
    
    if ([iphoneField.text isEqualToString:@""]) {
        
        
    }else if (![self checkTel:iphoneField.text]){
        
        
        
    }else{
        
        __block int timeout = 59;
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timerr = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timerr, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);//每秒执行
        dispatch_source_set_event_handler(timerr, ^{
            //倒计时结束 关闭
            if (timeout <= 0) {
                dispatch_source_cancel(timerr);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置界面按钮显示
                    [getCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                    getCodeButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
                    
                    getCodeButton.userInteractionEnabled = YES;
                });
                
            }else{
                int seconds = timeout % 60;
                NSString * strTime = [NSString stringWithFormat:@"%.2d",seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1];
                    [getCodeButton setTitle:[NSString stringWithFormat:@"%@秒后发送",strTime] forState:UIControlStateNormal];
                    [UIView commitAnimations];
                    getCodeButton.userInteractionEnabled = NO;
                    
                    getCodeButton.backgroundColor = [UIColor grayColor];
                    
                });
                timeout--;
            }
        });
        
        dispatch_resume(timerr);
    }
    
}

#pragma mark ------- 输入验证码后下一步走的方法  -------
- (void)ReturnNextController:(id)sender{
    
    
    
    if ([iphoneField.text isEqual:@""] && [passwordField.text isEqual:@""]) {
        
        [self checkTel:iphoneField.text];
        
    }
    
    NSString  * stri = [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_register.html?m=code&mobile=%@&code=%@",iphoneField.text,passwordField.text];
    
    NSString * str = [NSString stringWithFormat:@"mobile=%@&code=%@",iphoneField.text,passwordField.text];
    
    //关闭联想及首字母大写功能
    [passwordField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [passwordField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    NSLog(@"str:%@",stri);
    
    [self.sessionManager GET:stri parameters:str progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.codeArray = dic[@"errmsg"];
        
        if ([dic[@"errcode"] isEqual:@"1"]) {
            
            [UIView animateWithDuration:2.0 animations:^{
                
                [self SentientbeingspromptboxView:dic[@"errmsg"]];
            }];
            
        }else{
            
            TWPwdController * pwd  = [[TWPwdController alloc]init];
            
            pwd.phoneNumber = iphoneField.text;
            
            pwd.codeID = passwordField.text;
            
            [self.navigationController pushViewController:pwd animated:YES];
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([error isKindOfClass:[NSString class]]) {
            [self SentientbeingspromptboxView:@"网络连接异常"];
            
        }else {
            NSLog(@"error -- %@",error);
            
        }
        
    }];
}


//验证码为空的提示框调用
- (BOOL)checkCode:(NSString *)getCode{
    
    if ([passwordField.text  isEqual: @""]) {
        
        [UIView animateWithDuration:2.0 animations:^{
            
            [self SentientbeingspromptboxView:@"请输入您的验证码"];
        }];
        
    }
    return NO;
}

#pragma mark -------提示框 -------
- (void)SentientbeingspromptboxView:(NSString *)text{
    
    UILabel * lab = [[UILabel alloc]init];
    
    lab.numberOfLines = 0;
    
    lab.font = [UIFont systemFontOfSize:14.0];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    lab.layer.cornerRadius = 10;
    
    lab.text = text;
    
    lab.textColor = [UIColor whiteColor];
    
    lab.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
    
    [self.view addSubview:lab];
    
    [UIView animateWithDuration:2.0 animations:^{
        
        lab.alpha = 0.0;
        
    }];
    
   // [lab performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:3.0];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 160, 40));
        make.top.equalTo(self.view.mas_top).offset(280);
        
    }];
}


//电话号码
- (BOOL)checkTel:(NSString *)mobileNumbel

{
    /**
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        NSLog(@"手机号验证可用");
        return YES;
    }
    
    //提示语
    [UIView animateWithDuration:2.0 animations:^{
        
        [self SentientbeingspromptboxView:@"请输入正确的手机号码"];
        
    }];
    
    return NO;
    
}
//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

//放弃第一响应者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
