//
//  TWCerController.m
//  TWCompare
//
//  Created by TianView on 16/6/16.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWCerController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "TWUserModel.h"
#import "PrefixHeader.pch"
#import "AppDelegate.h"
#import "TWCerModels.h"
#import "SVProgressHUD.h"
#import "TWServiceController.h"
#import "LoginController.h"
#import "TWSJAvatarBrowser.h"
#import "TWSubmitController.h"

@interface TWCerController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{

    UIImage * headImage;

}
@property (nonatomic, strong)UITableView * tableview;
//UIImagePickerController是一个控制器，但是此类不能被继承
@property (nonatomic,strong)UIImagePickerController * imagePickerController;
@property (nonatomic,strong)NSData * imageData;
@property (nonatomic,strong)UIButton * textButton;
@property (nonatomic,strong)UIImage * imagePositive;//身份证正面
@property (nonatomic,strong)UIImage  *  imageOpposite;//身份证反面
@property (nonatomic,strong)UIImage * imageCard;//手持身份证
@property (nonatomic,strong)UIButton * button1;
@property (nonatomic,strong)UIButton * button2;
@property (nonatomic,strong)UIButton * button3;
@property (nonatomic,assign)NSInteger currentBtn;//全局变量
@property (nonatomic,copy)NSString * userNamed;//真实姓名

@property (nonatomic,strong)UIImageView * imageView;

@property (nonatomic,assign)BOOL b;
@property (nonatomic,strong)TWUserModel * userModel;

@property (nonatomic,strong)AFHTTPSessionManager * sessionManager;

@property (nonatomic,strong)NSMutableArray * arr;

@property (nonatomic,strong)UITapGestureRecognizer *tap;

@property (nonatomic,strong)UITapGestureRecognizer *tap1;
@property (nonatomic,strong)UITapGestureRecognizer *tap2;

@end

@implementation TWCerController
@synthesize tableview,imagePositive,button1,button2,button3,userNamed,imageOpposite,imageCard;

- (void)createNavbar{

}
- (void)viewWillAppear:(BOOL)animated{


//    if (_phpone) {
//        [paraDic setObject:_phpone forKey:@"mobile"];
//        NSLog(@":%@",_phpone);
//    }else{
//        [paraDic setObject:[UserInfo shareUserInfoSingleton].userDataModel.mobile forKey:@"mobile"];
//    }
//
//        [paraDic setObject:_flagorg forKey:@"m"];
//
//    NSLog(@"mobile:%@",[UserInfo shareUserInfoSingleton].userDataModel.mobile);
//
//    NSLog(@".......m:%@",_flagorg);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"44441");
    
    self.b = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.title= @"实名认证";
    
    [self.tableview reloadData];
    
    
    
    paraDic = [[NSMutableDictionary alloc]initWithCapacity:200];
    
    self.view.backgroundColor = [UIColor colorWithRed:238.0/255.0f green:238.0/255.0 blue:238.0/255.0f alpha:1.0f];
    
    
[self cgeateView];

    //网络请求相关
    self.sessionManager  = [AFHTTPSessionManager manager];
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    //系统相册调用
    self.imagePickerController = [[UIImagePickerController alloc]init];
    self.imagePickerController.allowsEditing = YES;//允许编辑
    self.imagePickerController.delegate = self;//遵循了两种协议；
//    self.imageButton.layer.cornerRadius = 60;
//    self.imageButton.layer.masksToBounds = YES;
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];

     tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    //footerView
    footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 340);
    tableview.tableFooterView = footerView;
    
    UIButton * but = [[UIButton alloc]init];
    but.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [but setTitle:@"下一步" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(SubmitButton) forControlEvents:UIControlEventTouchUpInside];
    but.layer.cornerRadius = 10;
    [footerView addSubview:but];
    
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(footerView.mas_right).offset(-40);
        make.left.equalTo(footerView.mas_left).offset(40);
        make.top.equalTo(footerView.mas_top).offset(20);
        make.height.equalTo(@40);
        
    }];
    
    UIButton  * attrLabel = [[UIButton alloc]init];
    [attrLabel setTitle:@"开店热线: 400-0871-347" forState:UIControlStateNormal];
    [attrLabel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [attrLabel addTarget:self action:@selector(ClickPhone) forControlEvents:UIControlEventTouchUpInside];
    attrLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:attrLabel];
    
    [attrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-70);
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH, 40));
        
    }];
  
}
- (void)ClickPhone{
    
    NSString * phone = @"400-0871-347";
    
    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",phone];
    // [[UIApplication sharedApplication] openURL:[NSURLURLWithString:num]]; //拨号
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:num]];
    
}
//创建 view
- (void)cgeateView{
    
    
    navView = [[UIView alloc]init];
    navView.backgroundColor = [UIColor whiteColor];
    navView.layer.borderWidth = 0.5;
    navView.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1]CGColor];

    if (self.renzhen) {
        
    }else {
        [self.view addSubview:navView];
    }
    

    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(5);
        make.centerX.equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH, 40));
        
    }];

    zhanghao = [[UILabel alloc]init];
    zhanghao.text = @"1.账号";
    
    zhanghao.textAlignment = NSTextAlignmentCenter;
    zhanghao.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:zhanghao];
    
    zhiliao = [[UILabel alloc]init];
    zhiliao.text = @"2.资料";
    
    zhiliao.textAlignment = NSTextAlignmentCenter;
    zhiliao.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:zhiliao];
    
    
    renzheng = [[UILabel alloc]init];
    renzheng.text = @"3.认证";
    
    renzheng.textAlignment = NSTextAlignmentCenter;
    renzheng.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:renzheng];

    //  NSArray * arr = [NSArray arrayWithObjects:@"1.账号",@"2.资料",@"3.认证",@"4.支付", nil];
    imageArray = [NSArray arrayWithObjects:@"register-12",@"register-13", nil];
    im = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:imageArray[0]];
    im.image = image;
    [navView addSubview:im];
    
    
    im1 = [[UIImageView alloc]init];
    UIImage * image1 = [UIImage imageNamed:imageArray[0]];
    im1.image = image1;
    [navView addSubview:im1];
    
    
    UserDataModel * userModel = [UserInfo shareUserInfoSingleton].userDataModel;

    
    
    if ([userModel.store_type isEqualToString:@"2"] || _storetype_id) {
        NSLog(@"bbbbbbbb");
        zhanghao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        
        [zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(navView.mas_left).offset(60);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        im = [[UIImageView alloc]init];
        UIImage * image = [UIImage imageNamed:imageArray[1]];
        im.image = image;
        [navView addSubview:im];
        
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(navView.mas_left).offset(120);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.top.equalTo(navView.mas_top).offset(13);
            
        }];
        zhiliao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        [zhiliao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhanghao.mas_right).offset(40);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        UIImage * image1 = [UIImage imageNamed:imageArray[1]];
        im1.image = image1;
        [navView addSubview:im1];
        
        [im1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(im.mas_right).offset(85);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.top.equalTo(navView.mas_top).offset(13);
            
        }];
        renzheng.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        
        [renzheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhiliao.mas_right).offset(40);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        
        
        
    }else{
        NSLog(@"aaaaaaa");
        zhanghao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        [zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(navView.mas_left).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        zhiliao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        
        [zhiliao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhanghao.mas_right).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        renzheng.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        
        [renzheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhiliao.mas_right).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        im = [[UIImageView alloc]init];
        UIImage * image = [UIImage imageNamed:imageArray[1]];
        im.image = image;
        [navView addSubview:im];
        
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(navView.mas_left).offset(85);
            make.size.mas_equalTo(CGSizeMake(10, 15));
            make.top.equalTo(navView.mas_top).offset(13);
            
        }];
        
        UIImage * image1 = [UIImage imageNamed:imageArray[1]];
        im1.image = image1;
        [navView addSubview:im1];
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

#define mark ----店铺标识示例 --------
- (void)addClick{
    
    
    if (self.b == YES) {

        
        NSLog(@"11111");

        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _viewBack.backgroundColor = [UIColor grayColor];
        _viewBack.alpha = 1.0;
        _viewBack.tag = 0;
        
        [self.view addSubview:_viewBack];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.imageView = [[UIImageView alloc]init];
            self.imageView.image = [UIImage imageNamed:@"register-11.png"];
            [_viewBack addSubview:_imageView];
            
            [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(self.viewBack);
                // make.left.equalTo(self.view.mas_left).offset(80);
                
                make.size.mas_equalTo(CGSizeMake(self.viewBack.frame.size.width,self.viewBack.frame.size.height));
                make.top.equalTo(@0);
                
            }];
            NSLog(@"2222");
            self.tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImageeyt)];
            
            [self.imageView addGestureRecognizer:self.tap];
            
            self.tap1  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewBackclick)];
            
            [self.viewBack addGestureRecognizer:self.tap];
 
            
            NSLog(@"444444");
            
        }];
        
        self.b = NO;
        
        return;
        
    }else{
        
        NSLog(@"3333");
        self.imageView.alpha = 0.0;
        self.b = YES;
        
        return;
    }

}
- (void)magnifyImageeyt{

    [self.imageView removeFromSuperview];
    
}
#define mark手持身份证照片示例放大方法 ----------
- (void)magnifyImage
{

    [self.imageView removeFromSuperview];

}
- (void)viewBackclick{

    [self.viewBack removeFromSuperview];
}

#define mark点击空白处图片消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

        if (_viewBack.tag == 0) {

            [_viewBack removeFromSuperview];
            
        }
  
}

#define mark下一步资料提交认证页面 --------
- (void)SubmitButton{

         //   http://www.tianview.com/api-upload_pic.html

    if ([textName.text length] == 0) {
        
        return [self SentientbeingspromptboxView:@"请输入姓名"];
    }
    
    if ([textID.text length] == 0 ){
        
        return [self SentientbeingspromptboxView:@"请输入身份证号"];
        
    }else {
        if (![self checkIdentityCardNo:textID.text]) {
            return [self SentientbeingspromptboxView:@"请输入正确的身份证号"];
           
        }
    }
    
    
    if ([paraDic[@"ID_img"] length] == 0){
        
        return [self SentientbeingspromptboxView:@"请上传身份证正面照片"];
    }else if ([paraDic[@"ID_img2"] length] == 0){
        
        return [self SentientbeingspromptboxView:@"请上传身份证反面照片"];
    }else if ([paraDic[@"handheld_ID_img"] length] == 0){
    
        return [self SentientbeingspromptboxView:@"请上传手持身份证照片"];
    }
    [paraDic setObject:textName.text forKey:@"truename"];
    [paraDic setObject:textID.text forKey:@"ID"];
   // [paraDic setObject:@"12" forKey:@"m"];
    if (_phpone) {
        [paraDic setObject:_phpone forKey:@"mobile"];
        NSLog(@":%@",_phpone);
    }else{
        [paraDic setObject:[UserInfo shareUserInfoSingleton].userDataModel.mobile forKey:@"mobile"];
    }
    
    [paraDic setObject:_flagorg forKey:@"m"];
    
    NSLog(@"mobile:%@",[UserInfo shareUserInfoSingleton].userDataModel.mobile);
    
    NSLog(@".......m:%@",_flagorg);

    NSLog(@"m:%@",[UserInfo shareUserInfoSingleton].userDataModel.flag);
    
     [SVProgressHUD showWithStatus:@"正在提交..."];
    
    //  http://www.tianview.com/api-ydz_update_store.html
    
    NSString * strUrl  = [NSString stringWithFormat:@"%@",UPDATEURL];

    NSLog(@"paraDic: %@",paraDic);
    
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    
    [self.sessionManager POST:strUrl parameters:paraDic progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"实名认证-----------dic%@",dic);
        
        self.arr = dic[@"data"];
        NSLog(@"self.arr:%@",self.arr);
 
        // [dic[@"errcode"] integerValue] == 0
        // ([[NSString stringWithFormat:@"%@",dic[@"errcode"]] isEqualToString:@"0"]
        if ([dic[@"errcode"] integerValue] == 0) {
            
            UserDataModel * userModel = [UserInfo shareUserInfoSingleton].userDataModel;
            
            if (self.renzhen) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                
            }else{
                
                if ([userModel.store_type isEqualToString:@"2"] || [_storetype_id isEqualToString:@"2"]) {
                    NSLog(@"_storetype_id:%@",_storetype_id);
                    
                    TWSubmitController * sub = [[TWSubmitController alloc]init];
                    
                    sub.userIphone = _phpone;
                    NSLog(@"sub.userIphone:%@",sub.userIphone);
                   // sub.useriphone = userModel.mobile;
                    sub.storye_ID_1 = _storeyID_00;
                    
                    NSLog(@"sub.storye_ID_1:%@",sub.storye_ID_1);
                    
                    [self.navigationController pushViewController:sub animated:YES];
                    
  
                }else{
                    
                    TWServiceController * tw = [[TWServiceController alloc]init];
                    
                    if (_phpone) {
//                        [paraDic setObject:_phpone forKey:@"mobile"];
                        tw.useriphone = _phpone;
                        
                        NSLog(@":%@",_phpone);
                    }else{

                        tw.useriphone = [UserInfo shareUserInfoSingleton].userDataModel.mobile;
                    }
                    
                    
                    NSLog(@"mobile:%@",[UserInfo shareUserInfoSingleton].userDataModel.mobile);
                    
                    NSLog(@".......m:%@",_flagorg);
                    
                    
                    
                    tw.storyIDL = _storeyID_00;
                    
                    [self.navigationController pushViewController:tw animated:YES];
                    
                }

                }
            
        }else {
            
            [self createAlertView:dic[@"errmsg"]];
        }
       
        [self dismisss];
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"error:%@",error);


}];


}



- (void)dismisss{
    
    [SVProgressHUD showSuccessWithStatus:@"提交成功!"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
        
        
    });
   
}

#pragma mark -------提示框 -------
- (void)SentientbeingspromptboxView:(NSString *)text{
    
    NSLog(@"33331");
    
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
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH - 160, 60));
        make.bottom.equalTo(self.view.mas_bottom).offset(-190);
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 1;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
  
    if (indexPath.section == 0) {
        static NSString * only =@"id9";
        UITableViewCell * cec =[tableView cellForRowAtIndexPath:indexPath];
        if (cec == nil) {
            cec =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:only];
        }
        
        //真实姓名
        userName = [[UILabel alloc]init];
        userName.text = @"真实姓名";
        userName.textAlignment = NSTextAlignmentLeft;
        userName.frame =CGRectMake(10, 10, 200, 40);
        [cec.contentView addSubview:userName];
        
        
        
        textName = [[UITextField alloc]init];
        textName.placeholder = @"填写真实姓名";
        textName.textColor = [UIColor colorWithRed:104.0/256.0f green:104.0/256.0f blue:104.0/256.0f alpha:0.5];
        textName.textAlignment = NSTextAlignmentLeft;
        textName.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-170, 10, 170, 40);
        [textName setAutocorrectionType:UITextAutocorrectionTypeNo];
        [textName setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        
        [cec.contentView addSubview:textName];
        
        cec.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cec;
        
    }else if (indexPath.section == 1){
        
        static NSString * only =@"id10";
        UITableViewCell * cey =[tableView cellForRowAtIndexPath:indexPath];
        if (cey == nil) {
            cey =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:only];
        }
        
        
        //身份证id
        cardID = [[UILabel alloc]init];
        cardID.text = @"身份证号";
        cardID.textAlignment = NSTextAlignmentLeft;
        cardID.frame =CGRectMake(10, 10, 200, 40);
        //  cardID.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-70, 20, 40, 40);
        
        [cey.contentView addSubview:cardID];
        
        
        
        //身份证号码
        textID = [[UITextField alloc]init];
        textID.placeholder = @"请填写真实的身份证号码";
        textID.textColor = [UIColor colorWithRed:104.0/256.0f green:104.0/256.0f blue:104.0/256.0f alpha:0.5];
        textID.textAlignment = NSTextAlignmentLeft;
        textID.keyboardType= UIKeyboardTypeNumberPad;
        textID.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-220, 10, 220, 40);
        [textID setAutocorrectionType:UITextAutocorrectionTypeNo];
        [textID setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [cey.contentView addSubview:textID];
        
        cey.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cey;
    }else if (indexPath.section == 2) {
        
        static NSString * only =@"id1";
        UITableViewCell * ce =[tableView cellForRowAtIndexPath:indexPath];
        if (ce == nil) {
            ce =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:only];
        }
        
        
        UILabel * lab = [[UILabel alloc]init];
        lab.frame =CGRectMake(10, 10, 200, 40);
        lab.text = @"身份证正面";
        [ce addSubview:lab];
        
        button1 =[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, 10, 40, 40)];
        [button1 setTitle:@"+" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setBackgroundColor:[UIColor grayColor]];
        // [button1 setImage:[UIImage imageNamed:@"默认头像-01"] forState:UIControlStateNormal];
        
        
        [button1 addTarget:self action:@selector(oneBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [ce addSubview: button1];
        
        ce.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return ce;
        
        
        
    }else if (indexPath.section == 3){
        
        static NSString * only =@"id1";
        UITableViewCell * cea =[tableView cellForRowAtIndexPath:indexPath];
        if (cea == nil) {
            cea =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:only];
        }
        
        
        UILabel * lab = [[UILabel alloc]init];
        lab.frame =CGRectMake(10, 10, 200, 40);
        lab.text = @"身份证反面";
        [cea addSubview:lab];
        
        button2 =[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, 10, 40, 40)];
        [button2 setTitle:@"+" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 setBackgroundColor:[UIColor grayColor]];
        //   [button2 setImage:[UIImage imageNamed:@"默认头像-01"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(secondview) forControlEvents:UIControlEventTouchUpInside];
        [cea addSubview: button2];
        
        cea.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cea;
        
        
    }else{
        
        
        static NSString * only =@"id1";
        UITableViewCell * ceb =[tableView cellForRowAtIndexPath:indexPath];
        if (ceb == nil) {
            ceb =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:only];
        }
        
        UILabel * lab = [[UILabel alloc]init];
        lab.frame =CGRectMake(10, 10, 200, 40);
        lab.text = @"手持身份证";
        [ceb addSubview:lab];
        
        button3 =[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, 10, 40, 40)];
        
        [button3 setTitle:@"+" forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button3 setBackgroundColor:[UIColor grayColor]];
        // [button3 setImage:[UIImage imageNamed:@"默认头像-01"] forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(thre) forControlEvents:UIControlEventTouchUpInside];
        
        [ceb addSubview: button3];
        
        
        //手持身份证示例按钮
        _textButton = [UIButton buttonWithType: UIButtonTypeCustom];
        _textButton.backgroundColor = [UIColor clearColor];
        [_textButton setTitle:@"示例" forState:UIControlStateNormal];
        _textButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_textButton setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_textButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        
        [ceb addSubview:_textButton];
        
        [_textButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(ceb.mas_left).offset(5);
            make.top.equalTo(ceb.mas_top).offset(38);
            make.height.equalTo(@20);
            make.width.equalTo(@60);
        }];
        
        
        ceb.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return ceb;
        
    }
    
    


}

#define mark3第三button点击事件
-(void)thre
{
    self.currentBtn=5;
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"选取照片" message:nil preferredStyle:0];
    UIAlertAction * actionone = [UIAlertAction actionWithTitle:@"照片库" style:0 handler:^(UIAlertAction *action) {
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    UIAlertAction * actiontwo = [UIAlertAction actionWithTitle:@"拍照" style:0 handler:^(UIAlertAction *action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertController * a = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备不存在摄像功能或摄像已损坏！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [a addAction:act];
            [self presentViewController:a animated:YES completion:nil];
            
        }else
        {
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }
    
    }];
    UIAlertAction * actionthree = [UIAlertAction actionWithTitle:@"胶卷" style:0 handler:^(UIAlertAction *action) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }];
    UIAlertAction * actionfour = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction *action) {
    }];
    
    [aler addAction:actionone];
    [aler addAction:actiontwo];
    [aler addAction:actionthree];
    [aler addAction:actionfour];
    
    [self presentViewController:aler animated:YES completion:nil];
}
#define mark8 第二button点击事件---------
-(void)secondview
{
    self.currentBtn=4;
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"选取照片" message:nil preferredStyle:0];
    UIAlertAction * actionone = [UIAlertAction actionWithTitle:@"照片库" style:0 handler:^(UIAlertAction *action) {
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    UIAlertAction * actiontwo = [UIAlertAction actionWithTitle:@"拍照" style:0 handler:^(UIAlertAction *action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertController * a = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备不存在摄像功能或摄像已损坏！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [a addAction:act];
            [self presentViewController:a animated:YES completion:nil];
            
        }else
        {
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }
    
    }];
    UIAlertAction * actionthree = [UIAlertAction actionWithTitle:@"胶卷" style:0 handler:^(UIAlertAction *action) {
        
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    UIAlertAction * actionfour = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction *action) {
    }];
    
    [aler addAction:actionone];
    [aler addAction:actiontwo];
    [aler addAction:actionthree];
    [aler addAction:actionfour];
    
    [self presentViewController:aler animated:YES completion:nil];
}
#define mark2第一button点击事件
-(void)oneBtn
{
    self.currentBtn=3;
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"选取照片" message:nil preferredStyle:0];
    UIAlertAction * actionone = [UIAlertAction actionWithTitle:@"照片库" style:0 handler:^(UIAlertAction *action) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }];
    UIAlertAction * actiontwo = [UIAlertAction actionWithTitle:@"拍照" style:0 handler:^(UIAlertAction *action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertController * a = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备不存在摄像功能或摄像已损坏！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [a addAction:act];
            [self presentViewController:a animated:YES completion:nil];
        }else
        {
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }
  
    }];
    UIAlertAction * actionthree = [UIAlertAction actionWithTitle:@"胶卷" style:0 handler:^(UIAlertAction *action) {
        
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    UIAlertAction * actionfour = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction *action) {
        
    }];
    
    [aler addAction:actionone];
    [aler addAction:actiontwo];
    [aler addAction:actionthree];
    [aler addAction:actionfour];
    
    [self presentViewController:aler animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
    
    cell1.selected = NO;  //（这种是点击的时候有效果，返回后效果消失）
}

#define mark调用系统相册上传 --------
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   
    
    headImage = info[@"UIImagePickerControllerEditedImage"];
   
    if (self.currentBtn == 3) {

        [button1 setImage:headImage forState:UIControlStateNormal];
        
    }else if (self.currentBtn == 4)
    {

      [button2 setImage:headImage forState:UIControlStateNormal];

    }else if (self.currentBtn == 5){

        [button3 setImage:headImage forState:UIControlStateNormal];

    }
    
    NSData * da = UIImageJPEGRepresentation(headImage, 0.4);
    
 //   NSLog(@"da:%@",da);
    
    [self uploadVoiceWithData:da];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //移除指示器
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    
}
#define mark提交认证图片放入字典
- (void)uploadVoiceWithData:(NSData *)data{
    

    
    NSMutableDictionary *dicde = [[NSMutableDictionary alloc] init];
    [dicde setObject:[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"file"];
    // NSLog(@"base64EncodedString == %@",dicd);
    
    
    NSString * urls = [[NSString stringWithFormat:@"%@",LOADURL]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    self.sessionManager  = [AFHTTPSessionManager manager];
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [SVProgressHUD showWithStatus:@"上传中......"];
    
    
  //  NSLog(@"dayinzidian:%@",dicde);
    [self.sessionManager POST:urls parameters:dicde progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"responseString:%@",responseString);

        NSDictionary *dicc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dicc:%@",dicc);
        
        if ([[NSString stringWithFormat:@"%@",dicc[@"errcode"]] isEqualToString:@"0"]) {
            //[self createAlertView:@"上传成功"];
            [self dismisss];
        }

        
        if (dicc[@"data"]) {
            if (self.currentBtn == 3) {
                [paraDic addEntriesFromDictionary:@{@"ID_img":dicc[@"data"]}];
                NSLog(@"ID_img:%@",paraDic);
            }else if (self.currentBtn == 4){
                [paraDic addEntriesFromDictionary:@{@"ID_img2":dicc[@"data"]}];
                NSLog(@"ID_img2:%@",paraDic);
            }else if (self.currentBtn == 5){
                [paraDic addEntriesFromDictionary:@{@"handheld_ID_img":dicc[@"data"]}];
                NSLog(@"handheld_ID_img:%@",paraDic);
            }
            
        }else {
        
            NSError * error;
            NSLog(@"上传失败:%@",error);
        }
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
 
}

//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
//滑动取消第一响应者
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint point = scrollView.contentOffset;
    
    if (point.y > 0.0001 || point.y < 0.0001) {
        
        [textName resignFirstResponder];
        [textID resignFirstResponder];
    }
}


//身份证号正则判断
- (BOOL)checkIdentityCardNo:(NSString*)cardNo

{
    
    if (cardNo.length != 18) {
    
        return  NO;
        
    }
    
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
   
    int val;
    
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    
    if (!isNum) {
        NSLog(@"输入的身份证号码不对");

        return NO;
    }
    
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
        
    }

    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];

    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {

        
        NSLog(@"验证身份证号码可用");
        return YES;
        
    }
    
   
    
    return  NO;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.navigationController popViewControllerAnimated:YES];
    

}



@end
