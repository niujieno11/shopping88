//
//  TWRegistController.m
//  TWCompare
//
//  Created by TianView on 16/6/15.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWRegistController.h"
#import "Masonry.h"
#import "TWPwdController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AppDelegate.h"
#import "TWUser.h"
#import "LoginController.h"
#import "TWInformationController.h"

#define HUD_SIZE CGSizeMake(150, 50)

@interface TWRegistController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    UILabel *successAlert;
    UIScrollView * scrollview;
}

@property (nonatomic,strong)AFHTTPSessionManager * sessionManager;
@property (nonatomic,strong)NSArray * array;
@property (nonatomic,strong)NSArray * codeArray;

@end

@implementation TWRegistController

-(void)createNavbar
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户注册";
    
    self.array = [NSArray new];
    self.codeArray = [NSArray new];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    scrollview = [[UIScrollView alloc]init];
   
    [self setTextField];
    
    scrollview.frame = CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT);
    scrollview.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];
   // scrollview.backgroundColor = [UIColor cyanColor];
    
    scrollview.delegate = self;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:scrollview];
    
    
     NSLog(@"%@",scrollview);
    navView = [[UIView alloc]init];
    navView.backgroundColor = [UIColor whiteColor];
    navView.layer.borderWidth = 0.5;
    navView.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1]CGColor];
    NSLog(@"111");
    [scrollview addSubview:navView];
    
    
    
     NSLog(@"222");

     NSLog(@"333");
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(scrollview.mas_top).offset(5);
        make.centerX.equalTo(scrollview);
        
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH, 40));
        
    }];

    [self cgeateView];

    
    //计时器button
    [getCodeButton addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
    
   
}

//创建 view
- (void)cgeateView{
    
    zhanghao = [[UILabel alloc]init];
    zhanghao.text = @"1.账号";
    
    zhanghao.textAlignment = NSTextAlignmentCenter;
    zhanghao.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:zhanghao];
    
    zhiliao = [[UILabel alloc]init];
    zhiliao.text = @"2.资料";
    zhiliao.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    zhiliao.textAlignment = NSTextAlignmentCenter;
    zhiliao.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:zhiliao];
   
    
    renzheng = [[UILabel alloc]init];
    renzheng.text = @"3.认证";
    renzheng.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    renzheng.textAlignment = NSTextAlignmentCenter;
    renzheng.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:renzheng];
    
    
   
    
    
    //  NSArray * arr = [NSArray arrayWithObjects:@"1.账号",@"2.资料",@"3.认证",@"4.支付", nil];
    NSArray * imageArray = [NSArray arrayWithObjects:@"register-12",@"register-13", nil];
    im = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:imageArray[0]];
    im.image = image;
    [navView addSubview:im];
    

    im1 = [[UIImageView alloc]init];
    UIImage * image1 = [UIImage imageNamed:imageArray[0]];
    im1.image = image1;
    [navView addSubview:im1];
    
    
    
   UserDataModel * userModel = [UserInfo shareUserInfoSingleton].userDataModel;
    

    if (_storetype   || [userModel.store_type isEqualToString:@"2"]) {
       zhanghao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        
        [zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(navView.mas_left).offset(60);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(navView.mas_left).offset(120);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.top.equalTo(navView.mas_top).offset(13);
            
        }];
        
        [zhiliao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhanghao.mas_right).offset(40);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        [im1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(im.mas_right).offset(85);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.top.equalTo(navView.mas_top).offset(13);
            
        }];
        
        [renzheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhiliao.mas_right).offset(40);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        
        
        
    }else{
        
        zhanghao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        
        [zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(navView.mas_left).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        [zhiliao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhanghao.mas_right).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        [renzheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhiliao.mas_right).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(navView.mas_left).offset(85);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.top.equalTo(navView.mas_top).offset(13);
            
        }];

        
        [im1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(im.mas_right).offset(80);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.top.equalTo(navView.mas_top).offset(13);
            
        }];
    
        pay = [[UILabel alloc]init];
        pay.text = @"4.支付";
        pay.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        pay.textAlignment = NSTextAlignmentCenter;
        pay.font = [UIFont systemFontOfSize:15.0];
        [navView addSubview:pay];
        [pay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(renzheng.mas_right).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        
        im2 = [[UIImageView alloc]init];
        UIImage * image2 = [UIImage imageNamed:imageArray[0]];
        im2.image = image2;
        [navView addSubview:im2];
        
        [im2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(im1.mas_right).offset(70);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.top.equalTo(navView.mas_top).offset(13);
            
        }];
    
    
    }
    
   
}

//设置手机号密码输入框
- (void)setTextField{
   
        //用户名
    userNameText = [[UITextField alloc]init];
    userNameText.placeholder=@"请输入用户名";
    userNameText.font = [UIFont systemFontOfSize:12];
    userNameText.delegate = self;
    
    userNameText.leftViewMode = UITextFieldViewModeAlways;
   // userNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameText.borderStyle = UITextBorderStyleRoundedRect;
    //userName.keyboardType = UIKeyboardTypeNumberPad;
    [scrollview addSubview:userNameText];
    
    //关闭联想及首字母大写功能
    [userNameText setAutocorrectionType:UITextAutocorrectionTypeNo];
    [userNameText setAutocapitalizationType:UITextAutocapitalizationTypeNone];

    //用户名偏移量
    userNamePaddingView =[[UIView alloc]init];
    userNameText.leftView = userNamePaddingView;
    userNameText.leftViewMode = UITextFieldViewModeAlways;
    [scrollview addSubview:userNamePaddingView];

    //用户名图标
    userImage = [[UIImageView alloc]init];
    UIImage * imguser = [UIImage imageNamed:@"register-01"];
    userImage.image = imguser;
    
    [userNamePaddingView addSubview:userImage];
    
    //用户名偏移量适配
    [userNamePaddingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(scrollview.mas_left).offset(35);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(scrollview.mas_top).offset(85);
        
    }];

    //用户名图标适配
    [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(scrollview.mas_left).offset(60);
        make.size.mas_equalTo(CGSizeMake(15, 20));
        make.top.equalTo(scrollview.mas_top).offset(95);
    }];
    
    
    
    //用户名适配
    [userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(scrollview.mas_top).offset(80);
        make.centerX.equalTo(scrollview);

        
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH, 40));
        
        
    }];
    
    //密码
    passwordTextField = [[UITextField alloc]init];
    passwordTextField.placeholder=@"请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:12];
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    //passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollview addSubview:passwordTextField];
    
    //密码偏移量
    passwordView =[[UIView alloc]init];
    passwordTextField.leftView = passwordView;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [scrollview addSubview:passwordView];
    
    //密码图标
    passwordImage = [[UIImageView alloc]init];
    UIImage * imgpassword = [UIImage imageNamed:@"register-02"];
    passwordImage.image = imgpassword;
    [passwordView addSubview:passwordImage];
    
    //密码图标适配
    [passwordImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(scrollview.mas_left).offset(60);
        make.size.mas_equalTo(CGSizeMake(15, 20));
        make.top.equalTo(scrollview.mas_top).offset(145);
    }];
    
    //密码偏移量适配
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(scrollview.mas_left).offset(35);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(scrollview.mas_top).offset(135);
        
    }];
    
    //密码适配
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        
        make.top.equalTo(scrollview.mas_top).offset(130);
        make.centerX.equalTo(scrollview);
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH + 2, 40));
    }];
    
    
    
    //手机号
    iphoneField = [[UITextField alloc]init];
    
    iphoneField.placeholder=@"请输入手机号码";
    iphoneField.font = [UIFont systemFontOfSize:12];
    iphoneField.delegate = self;
    iphoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    iphoneField.borderStyle = UITextBorderStyleRoundedRect;
    iphoneField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollview addSubview:iphoneField];
    
    
    //手机号偏移量
    paddingView1 =[[UIView alloc]init];
    iphoneField.leftView = paddingView1;
    iphoneField.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollview addSubview:paddingView1];

    
    //手机号图标
    imageview = [[UIImageView alloc]init];
    UIImage * img = [UIImage imageNamed:@"register-03"];
    imageview.image = img;
    
    [paddingView1 addSubview:imageview];

    
    
    //手机号图标适配
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(scrollview.mas_left).offset(60);
        make.size.mas_equalTo(CGSizeMake(15, 20));
        make.top.equalTo(scrollview.mas_top).offset(195);
    }];
    
    //手机号偏移量适配
    [paddingView1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(scrollview.mas_left).offset(35);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(scrollview.mas_top).offset(185);
        
    }];
    
    //手机号适配
    [iphoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(scrollview.mas_top).offset(180);
        make.centerX.equalTo(scrollview);
        
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH + 2, 40));
        
    }];
    
    
    
    //短信验证码
    passwordField = [[UITextField alloc]init];
    
    passwordField.placeholder=@"请输入短信验证码";
    passwordField.font = [UIFont systemFontOfSize:12];
   // passwordField.secureTextEntry = YES;
    passwordTextField.delegate = self;
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    
    passwordField.keyboardType = UIKeyboardTypeDefault;
    
    [scrollview addSubview:passwordField];
    
    //获取验证码
    getCodeButton = [[UIButton alloc]init];
    getCodeButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // getCodeButton.frame = CGRectMake(UISCREENORGINX -40, 142, UISCREENWIDTH / 3, 45);
    [getCodeButton addTarget:self action:@selector(GetCode:) forControlEvents:UIControlEventTouchUpInside];
    getCodeButton.layer.cornerRadius = 5;
   
    [scrollview addSubview:getCodeButton];
    
    //获取验证码适配
    [getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(scrollview.mas_right).offset(UISCREENWIDTH - 20);
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH / 3, 40)); //UISCREENWIDTH / 3
        make.top.equalTo(scrollview.mas_top).offset(230);
        
    }];
    
    //验证码偏移量
    paddingView2 =[[UIView alloc]init];
    passwordField.leftView = paddingView2;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollview addSubview:paddingView2];
    
    
    //验证码图标
    imageviewPass = [[UIImageView alloc]init];
    UIImage * img1 = [UIImage imageNamed:@"register-04"];
    imageviewPass.image = img1;
    
    [paddingView2 addSubview:imageviewPass];
    
    
    
    //验证码图标适配
    [imageviewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(scrollview.mas_left).offset(60);
        make.size.mas_equalTo(CGSizeMake(15, 20));
        make.top.equalTo(scrollview.mas_top).offset(215);
    }];

    
    //验证码偏移量适配
    [paddingView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(scrollview.mas_left).offset(35);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(scrollview.mas_top).offset(205);
        
    }];
    
    //验证码适配
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(scrollview.mas_top).offset(230);
       // make.left.equalTo(scrollview.mas_left).offset(20);
         make.centerX.equalTo(scrollview);
        
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH + 2, 40));
        
    }];

    
    //下一步
    nextButton = [[UIButton alloc]init];
    nextButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(ReturnNextController:) forControlEvents:UIControlEventTouchUpInside];
    
    nextButton.layer.cornerRadius = 10;

    [scrollview addSubview:nextButton];

    
    //下一步适配
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(scrollview.mas_bottom).offset(360);
        make.centerX.equalTo(scrollview.mas_centerX);

        make.size.mas_equalTo(CGSizeMake((UISCREENWIDTH / 2) + 100, 40));
    }];
  
    
    UIButton  * attrLabel = [[UIButton alloc]init];
    [attrLabel setTitle:@"开店热线: 400-0871-347" forState:UIControlStateNormal];
    [attrLabel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [attrLabel addTarget:self action:@selector(ClickPhone) forControlEvents:UIControlEventTouchUpInside];
    attrLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [scrollview addSubview:attrLabel];
    
    [attrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(scrollview.mas_bottom).offset(440);
        make.centerX.equalTo(scrollview.mas_centerX);
        
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH, 40));
        
    }];
    
}
- (void)ClickPhone{

    NSString * phone = @"400-0871-347";
    
    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",phone];
   // [[UIApplication sharedApplication] openURL:[NSURLURLWithString:num]]; //拨号
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:num]];

}

#pragma mark ------- 获取验证码按钮 判断errcode 如果为0则填验证码进行下一步注册 如果不为0则返回主页面进行登录操作 -------
- (void)GetCode:(id)sender{
    
    if ([iphoneField.text isEqualToString:@""]) {
        [self createAlertView:@"请填写手机号!"];

    }else if (![self checkTel:iphoneField.text]){
        [self createAlertView:@"请填写正确的手机号!"];

    }else{
        //www.tianview.com/api-ydz_register.html?m=vercode&mebile=88888888888//获取验证码
       // www.tianview.com/api-ydz_register.html?m=register&mebile=88888888888&password=888888&code=验证码&member_name=易云店名
        //  http://www.tianview.com/api-ydz_register.html?m=vercode&mobile=15623734871
        NSString * strUrl  = [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_register.html?m=vercode&mobile=%@",iphoneField.text];
        
        NSLog(@"url:%@",strUrl);
        NSString * str = [NSString stringWithFormat:@"mobile=%@",iphoneField.text];
        

        //网络请求相关
        self.sessionManager  = [AFHTTPSessionManager manager];
        
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        
        [self.sessionManager GET:strUrl parameters:str progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary * dd =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         
            NSLog(@"dd:%@",dd);

            if ([[NSString stringWithFormat:@"%@",dd[@"errcode"]] isEqualToString:@"1"]) {

                UIAlertController * a = [UIAlertController alertControllerWithTitle:@"温馨提示" message:dd[@"errmsg"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                    LoginController * login =[[LoginController alloc]init];
                    
                    [self.navigationController pushViewController:login animated:YES];
  
                }];
                [a addAction:act];
                [self presentViewController:a animated:YES completion:nil];

            }
  
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];

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

#pragma mark ------- 下一步走的方法  -------
- (void)ReturnNextController:(id)sender{

    if (userNameText.text.length == 0) {

        [self createAlertView:@"用户名不能为空!"];
        return;
    }else if (iphoneField.text.length == 0){

        [self createAlertView:@"请填写正确的手机号!"];
        return;
    }else if (![self checkTel:iphoneField.text]){
        [self createAlertView:@"手机号不正确!"];
         return;
    }else if (passwordTextField.text.length == 0){

        [self createAlertView:@"密码不能为空!"];
        return;
        
    }else if (passwordField.text.length == 0){

        [self createAlertView:@"验证码不能为空!"];
        return;
    }

    
    NSDictionary * priDic;
    
    if (_story_id_2) {
        
        priDic =[NSDictionary dictionaryWithObjects:@[@"register",iphoneField.text,passwordTextField.text,passwordField.text,userNameText.text,_story_id_2,] forKeys:@[@"m",@"mobile",@"password",@"code",@"member_name",@"parent_id"]];
      //  stri = [[NSString stringWithFormat:@"http://www.tianview.com/api-ydz_register.html?m=register&mobile=%@&password=%@&code=%@&member_name=%@&parent_id=%@",iphoneField.text,passwordTextField.text,passwordField.text,userNameText.text,_story_id_2]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
          }else{

                priDic =[NSDictionary dictionaryWithObjects:@[@"register",iphoneField.text,passwordTextField.text,passwordField.text,userNameText.text] forKeys:@[@"m",@"mobile",@"password",@"code",@"member_name"]];
              
    }
        
    NSLog(@"priDic:%@",priDic);

   // NSS tring  * stri = [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_register.html?m=code&mobile=%@&code=%@",iphoneField.text,passwordField.text];

 
    //关闭联想及首字母大写功能
    [passwordField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [passwordField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"提交中...";
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:@"ydz_register" Parameters:priDic style:kConnectPostType success:^(id dic) {
        
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSLog(@"ydz_register == %@", dic);
        
        self.codeArray = dic[@"errmsg"];
        
        if ([dic[@"errcode"] isEqualToString:@"1"]) {
            
            [self createAlertView:dic[@"errmsg"]];
            
        }else{

            UserDataModel * userModel = [UserInfo shareUserInfoSingleton].userDataModel;
            
            if ([userModel.flag isEqualToString:@"11"] && [userModel.store_type isEqualToString:@"1"] && [userModel.is_guarantee isEqualToString:@"0"] ) {
                TWInformationController *  TWInformation = [[TWInformationController alloc]init];
                
                [self.navigationController pushViewController:TWInformation animated:YES];
            }
            
            TWInformationController * pwd = [[TWInformationController alloc]init];
            
            pwd.phoneNumber = iphoneField.text;
            pwd.flag = [NSString stringWithFormat:@"%d",11];
            //            _storetype = type;
            pwd.storetype = _storetype;
            pwd.storyID_ = _story_id_2;
            
            NSLog(@"pwd.storetype:%@",pwd.storetype);
            
            NSLog(@"pwd.flag:%@",pwd.flag);
            
            NSLog(@"iphoneField.text:%@",iphoneField.text);
            
            [self.navigationController pushViewController:pwd animated:YES];
            
        }
    
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
//  验证码为空的提示框调用
- (BOOL)checkCode:(NSString *)getCode{

    if (passwordField.text.length == 0) {
        
        [UIView animateWithDuration:2.0 animations:^{
           
            [self createAlertView:@"请输入您的验证码"];
        }];
    }
    return NO;
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

    return NO;
   
}
//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



@end
