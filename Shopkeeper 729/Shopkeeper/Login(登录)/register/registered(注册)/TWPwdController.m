//
//  TWPwdController.m
//  TWCompare
//
//  Created by TianView on 16/6/15.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWPwdController.h"
#import "Masonry.h"
#import "TWOpenController.h"
#import "AFHTTPSessionManager.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "SVProgressHUD.h"



@interface TWPwdController ()
@property(nonatomic,copy)NSString * pwd1;//输入密码
@property(nonatomic,copy)NSString * pwd2;//再次输入密码
@property (nonatomic,strong)AFHTTPSessionManager * sessionManager;
@property (nonatomic,strong)NSArray * pwdArray;

@end

@implementation TWPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pwdArray = [NSArray array];
    
    [self setPassWord];
   
    self.view.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];
    
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    view.frame= CGRectMake(0, 20, self.view.frame.size.width, 44);
    
    [self.view addSubview:view];
    
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];
    
    
    //判断两次输入的密码是否一致 不一致给弹出框

    UIView * view0 = [[UIView alloc]init];
    
    view0.backgroundColor = [UIColor whiteColor];
    
    view0.hidden = NO;
    
    view0.frame = CGRectMake(0, 0, 300, 400);
    
    [self.view addSubview:view0];
    

    if (![self.pwd1 isEqualToString:self.pwd2]) {
        
        
        view0.hidden = YES;
    }
    
    
}

- (void)setPassWord{

    pwdField1 = [[UITextField alloc]init];
    
    pwdField1.secureTextEntry = YES;
    pwdField1.placeholder=@"请输入新密码";
    
    pwdField1.text = self.pwd1;
    
    pwdField1.font = [UIFont systemFontOfSize:14];
    pwdField1.secureTextEntry = YES;
    pwdField1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdField1];
    
    
    
    pwdField2 = [[UITextField alloc]init];
    
    pwdField2.secureTextEntry = YES;
    pwdField2.placeholder=@"请再次输入新密码";
    
    pwdField2.text = self.pwd2;
    
    pwdField2.font = [UIFont systemFontOfSize:14];
    pwdField2.secureTextEntry = YES;
    pwdField2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdField2];
    
    //确认
    determineButton = [[UIButton alloc]init];
    determineButton.backgroundColor =[UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [determineButton setTitle:@"确认" forState:UIControlStateNormal];
    [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determine:) forControlEvents:UIControlEventTouchUpInside];
    determineButton.layer.cornerRadius = 10;
    
    [self.view addSubview:determineButton];
    
    
    [pwdField1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 40, 50));
        make.top.mas_equalTo(self.view.mas_top).offset(90);
        
    }];

     [pwdField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.centerX.mas_equalTo(self.view.mas_centerX);
         make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 40, 50));
         make.top.mas_equalTo(self.view.mas_top).offset(145);
         
     }];
    
    [determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 40, 50));
        make.top.mas_equalTo(self.view.mas_top).offset(220);
    }];

}
#pragma mark -------确认-------
- (void)determine:(UIButton *)sender{
    
    
    Reachability * r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    NetworkStatus status = [r currentReachabilityStatus];
    
    if (status == NSNotFound) {
        //无网络
        [self notReaNet];
    }else{
    //有网络
        [self Load];
    
    }
    
    
      
}
#define mark无网络
- (void)notReaNet{

    [self SentientbeingspromptboxView:@"请检查网络!"];

}
#define mark有网络
- (void)Load{
    //网络请求相关
    self.sessionManager  = [AFHTTPSessionManager manager];
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    // 注册接口
    // ：http://www.tianview.com/api-ydz_register.html?m=register&mobile=18213561340&password=123456

    //分销注册
   // http://www.tianview.com/api-ydz_register.html?m=register&parent_ids=3&mobile=18213561340&password=123456
    
    NSString * temp;
    
    _pwd1 = [NSString stringWithFormat:@"%@",pwdField1.text];
    _pwd2 = [NSString stringWithFormat:@"%@",pwdField2.text];
    
    temp = _pwd1;
    
    _pwd2 = temp;
    
    _pwd1 = _pwd2;
    
    
    NSString  *s = @"http://www.tianview.com/api-ydz_register.html?m=register";
    
    
    if ([s rangeOfString:@"m=register"].location != NSNotFound) {
        
        NSString * str = [NSString stringWithFormat:@"%@&mobile=%@&parent_ids=%@&password=%@",s,_phoneNumber,_story_id_3,_pwd1];
        
        NSLog(@"str:%@",str);
        //参数
        NSString * stri = [NSString stringWithFormat:@"mobile=%@&parent_ids=%@&password=%@",_phoneNumber,_story_id_3,_pwd1];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"加载中...";
        
        [self.sessionManager GET:str parameters:stri progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            NSString * errmsging = [NSString stringWithFormat:@"%@",dic[@"errmsg"]];
            
            self.pwdArray = dic[@"errcode"];
            
            if ([dic[@"errcode"] isEqual:@"1"]) {
                
                UIAlertController * a = [UIAlertController alertControllerWithTitle:@"温馨提示" message:errmsging preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSLog(@"errcode为1是云店主走的方法");
                    
                }];
                
                [a addAction:act];
                
                [self presentViewController:a animated:YES completion:nil];
            }else{
                
                [self SentientbeingspromptboxView:@"账号或密码错误!"];
            }
            
            //移除指示器
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //移除指示器
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([error isKindOfClass:[NSString class]]) {
                [self SentientbeingspromptboxView:@"网络连接异常"];
                
            }else {
                NSLog(@"error -- %@",error);
                
            }
            
        }];
        
    }else{
    
    
  
    
    NSString * str = [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_register.html?m=register&mobile=%@&password=%@",_phoneNumber,_pwd1];
    
    NSLog(@"str:%@",str);
    //参数
    NSString * stri = [NSString stringWithFormat:@"mobile=%@&password=%@",_phoneNumber,_pwd1];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    
    [self.sessionManager GET:str parameters:stri progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSString * errmsging = [NSString stringWithFormat:@"%@",dic[@"errmsg"]];
        
        self.pwdArray = dic[@"errcode"];
        
        if ([dic[@"errcode"] isEqual:@"1"]) {
            
            UIAlertController * a = [UIAlertController alertControllerWithTitle:@"温馨提示" message:errmsging preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"errcode为1是云店主走的方法");
                
            }];
            
            [a addAction:act];
            
            [self presentViewController:a animated:YES completion:nil];
        }else{
            
            [self SentientbeingspromptboxView:@"账号或密码错误!"];
        }
        
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
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
    
    if ([pwdField1.text length] > 0 && [pwdField2.text length] > 0 && ![pwdField1.text isEqualToString:pwdField2.text]){
        
        [UIView animateWithDuration:3.0 animations:^{
            
            [self SentientbeingspromptboxView:@"两次密码输入不一致,请重新输入!"];
            
        }];
        
    }else{
        
        TWOpenController * open = [[TWOpenController alloc]init];
        open.iphoneNumber = _phoneNumber;
        [self.navigationController pushViewController:open animated:YES];
        
        
    }

    

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
    
    [lab performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:3.0];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 160, 40));
        make.top.mas_equalTo(self.view.mas_top).offset(280);
        
    }];
}

//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
