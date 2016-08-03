//
//  FindPWSetPWController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "FindPWSetPWController.h"

@interface FindPWSetPWController ()

@end

@implementation FindPWSetPWController


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
    [titleLable setFont:[UIFont systemFontOfSize:14]];
    [titleLable setTextAlignment:1];
    [navView addSubview:titleLable];
}


-(void)backbButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createUi
{
    NSArray * arr = @[@"请输入新密码", @"请再次输入新密码"];
    
    //1.输入框及背景
    for (int i = 0; i < 2; i++) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-140, 120+i*65, 280, 50)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [bgView.layer setCornerRadius:5];
        [bgView.layer setBorderColor:RGBCOLOR(235, 235, 235).CGColor];
        [bgView.layer setBorderWidth:1];
        [self.view addSubview:bgView];
        
        
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-120, 120+i*65, 240, 50)];
//        [textField setBackgroundColor:[UIColor greenColor]];
        [textField setPlaceholder:arr[i]];
        [textField setFont:[UIFont systemFontOfSize:14]];
        [self.view addSubview:textField];
        if (i == 0) {
            _nwePWTextField = textField;
        }else {
            _beSurePWTextField = textField;
        }
    }
    
    //2.登录按钮
    UIButton * finishButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-140, 270, 280, 50)];
    [finishButton setBackgroundColor:KMainColor];
    [finishButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton setTitle:@"完 成" forState:UIControlStateNormal];
    [finishButton.layer setCornerRadius:4];
    [finishButton addTarget:self action:@selector(finishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    
}

-(void)finishButtonAction
{
    if (_nwePWTextField.text.length == 0) {
        [self createAlertView:@"请输入新密码"];
        return;
    }
    if (_beSurePWTextField.text.length == 0) {
        [self createAlertView:@"请再次输入新密码"];
        return;
    }
    if (![_nwePWTextField.text isEqualToString:_beSurePWTextField.text]) {
        [self createAlertView:@"两次输入的新密码不一致"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 1.手机号码
    [dic setObject:_phoneNum forKey:@"mobile"];
    
    [dic setObject:_beSurePWTextField.text forKey:@"pswd"];

    [dic setObject:_code forKey:@"smscode"];
    
    [dic setObject:@"code" forKey:@"m"];
    
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kFindPW Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kSetdPW == %@",dic);
        if ([dic objectForKey:@"errcode"]) {
            if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
                
                LoginController * logvc;
                for (UIViewController * vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[LoginController class]]) {
                        logvc = (LoginController *)vc;
                        [logvc createAlertView:@"重置成功"];
                        [self.navigationController popToViewController:logvc animated:YES];
                    }
                }
               
                
            }
        }
        
        
    } failure:^(NSError *error) {
        
    }];

}
@end
