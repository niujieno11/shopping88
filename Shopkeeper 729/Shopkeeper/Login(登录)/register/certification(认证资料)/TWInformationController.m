//
//  TWInformationController.m
//  TWCompare
//
//  Created by TianView on 16/6/21.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWInformationController.h"
#import "Masonry.h"
#import "UserDataModel.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIImage+WebP.h"
#import "TWAgreeController.h"
#import "TWCerController.h"
#import "PrefixHeader.pch"
//#import "TWSJAvatarBrowser.h"




@interface TWInformationController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{

    UIImage * headerImage;

}
@property (nonatomic,strong)UITableView * tableview;

//UIImagePickerController是一个控制器，但是此类不能被继承
@property (nonatomic,strong)UIImagePickerController * imagePickerController;
@property (nonatomic,strong)NSData * imageData;
@property (nonatomic,strong)AFHTTPSessionManager * sessionManager;
@property (nonatomic, strong)NSMutableArray * imagearray;
@property (nonatomic,assign) BOOL b;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong)UITapGestureRecognizer *tap;
@property (nonatomic,strong)UITapGestureRecognizer *tap1;
@property (nonatomic,strong)UITapGestureRecognizer *tap2;

@end

@implementation TWInformationController
-(void)createNavbar
{
    
}
-(void)setTitleName:(NSString *)titleName{
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"店铺资料";
    
    self.b = YES;
    
    [self setCifimn];
    
    NSLog(@"story:%@",_storetype);
    
    [self cgeateView];
    
     [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.imagearray =[NSMutableArray array];
    
    pramDic = [[NSMutableDictionary alloc]init];
    
    self.view.backgroundColor = [UIColor colorWithRed:238.0/256.0f green:238.0/256.0 blue:238.0/256.0f alpha:1.0f];

    
    self.tableview = [[UITableView alloc]init];
    self.tableview.frame = CGRectMake(0, 64, self.view.frame.size.width, 274);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.view addSubview:self.tableview];
    
    self.imagePickerController = [[UIImagePickerController alloc]init];
    self.imagePickerController.allowsEditing = YES;//允许编辑
    self.imagePickerController.delegate = self;//遵循了两种协议；
    //    self.imageButton.layer.cornerRadius = 60;
    //    self.imageButton.layer.masksToBounds = YES;
    [self cgeateView];
   
}

//创建 view
- (void)cgeateView{
    
    navView = [[UIView alloc]init];
    navView.backgroundColor = [UIColor whiteColor];
    navView.layer.borderWidth = 0.5;
    
    navView.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1]CGColor];
    NSLog(@"111");
    [self.view addSubview:navView];
    
    NSLog(@"navView:%@",navView);
    
    NSLog(@"222");
    
    NSLog(@"333");
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(5);
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH, 40));
        
    }];

    zhanghao = [[UILabel alloc]init];
    zhanghao.text = @"1.账号";
    zhanghao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
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
    renzheng.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    renzheng.textAlignment = NSTextAlignmentCenter;
    renzheng.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:renzheng];
    //  NSArray * arr = [NSArray arrayWithObjects:@"1.账号",@"2.资料",@"3.认证",@"4.支付", nil];
    imageArray = [NSArray arrayWithObjects:@"register-12",@"register-13", nil];
    im = [[UIImageView alloc]init];

    
    im1 = [[UIImageView alloc]init];
    UIImage * image1 = [UIImage imageNamed:imageArray[0]];
    im1.image = image1;
    [navView addSubview:im1];

    if (_storetype || [[UserInfo shareUserInfoSingleton].userDataModel.store_type isEqualToString:@"2"]) {

        [zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(navView.mas_left).offset(60);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
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
        
        zhiliao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
        [zhiliao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhanghao.mas_right).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        renzheng.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        [renzheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navView.mas_top).offset(5);
            make.left.equalTo(zhiliao.mas_right).offset(30);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
            
        }];
        
        UIImage * image = [UIImage imageNamed:imageArray[1]];
        im.image = image;
        [navView addSubview:im];
        
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

//确认按扭
- (void)setCifimn{

    _confirmButton = [[UIButton alloc]init];
    _confirmButton.layer.cornerRadius = 10;
    _confirmButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [_confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(confirmButtoning) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_confirmButton];
    
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH - 40, 44));
        make.top.mas_equalTo(self.view.mas_top).offset(360);
  
    }];
    
    UIButton  * attrLabel = [[UIButton alloc]init];
    [attrLabel setTitle:@"开店热线: 400-0871-347" forState:UIControlStateNormal];
    [attrLabel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [attrLabel addTarget:self action:@selector(ClickPhone) forControlEvents:UIControlEventTouchUpInside];
    attrLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:attrLabel];
    
    [attrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
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

#define mark下一步店铺设置模块 ------
- (void)confirmButtoning{

    if ([_storeTextField.text length] == 0) {
        
        return [self SentientbeingspromptboxView:@"请输入店铺名称"];
    }else if ([pramDic[@"logo"] length] ==0){
        
        return [self SentientbeingspromptboxView:@"请上传店铺LOGO"];
    }else if ([pramDic[@"banner"] length] == 0){
        
        return [self SentientbeingspromptboxView:@"请上传店铺招牌图片"];
    }else if ([pramDic[@"weixin_qrcode"] length] == 0){
        
        return [self SentientbeingspromptboxView:@"请上传店铺微信二维码"];
    }
    
    [pramDic setObject:_storeTextField.text forKey:@"stores_name"];

    
    if (_phoneNumber) {
        [pramDic setObject:_phoneNumber forKey:@"mobile"];
    }else{
    [pramDic setObject:[UserInfo shareUserInfoSingleton].userDataModel.mobile forKey:@"mobile"];
    }

    if ( [UserInfo shareUserInfoSingleton].userDataModel.flag  ) {
         [pramDic setObject:[UserInfo shareUserInfoSingleton].userDataModel.flag forKey:@"m"];
    }else {
         [pramDic setObject:@"11" forKey:@"m"];
    }
    
    NSLog(@"infor m:%@",[UserInfo shareUserInfoSingleton].userDataModel.flag);
         NSLog(@"pramDic00000=== %@",pramDic);
    
      [SVProgressHUD showWithStatus:@"上传中......"];

        self.sessionManager  = [AFHTTPSessionManager manager];
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString * strUrl  = [NSString stringWithFormat:@"%@",UPDATEURL];
//        NSString * ecode = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
 
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        
        
        [self.sessionManager POST:strUrl parameters:pramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

            NSLog(@"店铺资料........dic%@",dic);
            
            if ([dic[@"errcode"] integerValue] == 0) {
                
                TWCerController * cer = [[TWCerController alloc]init];
                
                cer.phpone = _phoneNumber;
                cer.flagorg = [NSString stringWithFormat:@"%d",12];
                cer.storetype_id = _storetype;
                cer.storeyID_00 = _storyID_;
                
                NSLog(@"cer.storetype:%@",cer.storetype_id);
                
                [self.navigationController pushViewController:cer animated:YES];
            }
            
            [self dismisss];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showWithStatus:@"请求超时!"];
            
            NSLog(@"error:%@",error);
        }];

    [self dismisss];
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
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 160, 60));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100);
        
    }];
}


#define mark刷新上传成功走的方法

- (void)dismisss{
    
    [SVProgressHUD showSuccessWithStatus:@"上传成功!"];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
  
    });

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"cell";
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    if (indexPath.row == 0) {
        _storeName = [[UILabel alloc]init];
        _storeName.text = @"店铺名称";
        _storeName.textColor = [UIColor colorWithRed:103.0/255.0f green:103.0/255.0f blue:103.0/255.0f alpha:0.5];
        [cell addSubview:_storeName];
        
        _storeTextField = [[UITextField alloc]init];
        _storeTextField.placeholder = @"请输入店铺名称";
        _storeTextField.textAlignment = NSTextAlignmentCenter;
        _storeTextField.textColor = [UIColor colorWithRed:81.0/255.0 green:58.0/255.0 blue:40.0/255.0 alpha:1.0];
        
        [cell addSubview:_storeTextField];
        
        
        [_storeName mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(cell.mas_left).offset(20);
            make.top.equalTo(cell.mas_top).offset(2);
            make.width.equalTo(@200);
            make.height.equalTo(@40);
            
        }];
        [_storeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(cell.mas_right).offset(-10);
            make.top.equalTo(cell.mas_top).offset(2);
            make.width.equalTo(@200);
            make.height.equalTo(@40);
            
        }];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else if (indexPath.row == 1){
    
        _storeSign = [[UILabel alloc]init];
        _storeSign.text = @"店铺标识";
        _storeSign.textColor = [UIColor colorWithRed:103.0/255.0f green:103.0/255.0f blue:103.0/255.0f alpha:0.5];;
        
        [cell addSubview:_storeSign];
        
        _indfierButton = [[UIButton alloc]init];
        _indfierButton.layer.cornerRadius = 35;
        _indfierButton.layer.masksToBounds = YES;
        _indfierButton.backgroundColor = [UIColor grayColor];
        [_indfierButton setImage:[UIImage imageNamed:@"register-05"] forState:UIControlStateNormal];
        [_indfierButton setTitle:@"+" forState:UIControlStateNormal];
        [_indfierButton addTarget:self action:@selector(makeindfierButton:) forControlEvents:UIControlEventTouchUpInside];
        [_indfierButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [cell addSubview:_indfierButton];
        
        [_storeSign mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(cell.mas_left).offset(20);
            make.top.equalTo(cell.mas_top).offset(15);
            make.width.equalTo(@200);
            make.height.equalTo(@40);
            
        }];
        
        [_indfierButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(cell.mas_right).offset(-50);
            make.top.equalTo(cell.mas_top).offset(5);
            make.height.equalTo(@70);
            make.width.equalTo(@70);
        }];
        
  //示例
        UIButton * but = [[UIButton alloc]init];
        [but setTitle:@"示例" forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13.0];
       // but.backgroundColor = [UIColor redColor];
        but.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 0, 0);
        [but setTitleColor:[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.mas_left).offset(13);
            make.top.equalTo(cell.mas_top).offset(30);
            make.width.equalTo(@80);
            make.height.equalTo(@50);
            
        }];
        
        //显示最右边的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else if (indexPath.row == 2){
    
    
        _storeSign = [[UILabel alloc]init];
        _storeSign.text = @"店铺招牌图";
        _storeSign.textColor = [UIColor colorWithRed:103.0/255.0f green:103.0/255.0f blue:103.0/255.0f alpha:0.5];;
        
        [cell addSubview:_storeSign];
        
        _signButton = [[UIButton alloc]init];
        _signButton.layer.cornerRadius = 35;
        _signButton.layer.masksToBounds = YES;
        _signButton.backgroundColor = [UIColor grayColor];
        [_signButton setTitle:@"+" forState:UIControlStateNormal];
        [_signButton setImage:[UIImage imageNamed:@"register-05"] forState:UIControlStateNormal];
        [_signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signButton addTarget:self action:@selector(SignmakeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:_signButton];
        
        [_storeSign mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.mas_left).offset(20);
            make.top.equalTo(cell.mas_top).offset(15);
            make.width.equalTo(@200);
            make.height.equalTo(@40);
            
        }];
        
        [_signButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.mas_right).offset(-50);
            make.top.equalTo(cell.mas_top).offset(5);
            make.height.equalTo(@70);
            make.width.equalTo(@70);
            
            
        }];
        
        //示例
        UIButton * but = [[UIButton alloc]init];
        [but setTitle:@"示例" forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13.0];
       // but.backgroundColor =[UIColor redColor];
        but.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 0, 0);
        [but setTitleColor:[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(addClick_signButton) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.mas_left).offset(13);
            make.top.equalTo(cell.mas_top).offset(30);
            make.width.equalTo(@80);
            make.height.equalTo(@50);
            
        }];
        //显示最右边的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }else if (indexPath.row == 3){

        _storeCode = [[UILabel alloc]init];
        _storeCode.text = @"微信二维码";
        _storeCode.textColor = [UIColor colorWithRed:103.0/255.0f green:103.0/255.0f blue:103.0/255.0f alpha:0.5];;
        
        [cell addSubview:_storeCode];
        
        _codeButton = [[UIButton alloc]init];
       // _codeButton.layer.cornerRadius = 35;
        _codeButton.backgroundColor = [UIColor grayColor];
        [_codeButton setTitle:@"+" forState:UIControlStateNormal];
        [_codeButton setImage:[UIImage imageNamed:@"register-06"] forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(codeMakeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:_codeButton];
        
        [_storeCode mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.mas_left).offset(20);
            make.top.equalTo(cell.mas_top).offset(5);
            make.width.equalTo(@200);
            make.height.equalTo(@40);
            
        }];
        
        [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.mas_right).offset(-65);
            make.top.equalTo(cell.mas_top).offset(10);
            make.height.equalTo(@40);
            make.width.equalTo(@40);
            
            
        }];
        
        //示例
        UIButton * but = [[UIButton alloc]init];
        [but setTitle:@"示例" forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13.0];
       // but.backgroundColor = [UIColor redColor];
        but.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
        [but setTitleColor:[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(addClick_storeCode) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.mas_left).offset(10);
            make.top.equalTo(cell.mas_top).offset(25);
            make.width.equalTo(@80);
            make.height.equalTo(@50);
            
        }];
        
        //示例
        UIButton * butt = [[UIButton alloc]init];
        [butt setTitle:@"如何获取微信二维码" forState:UIControlStateNormal];
        butt.titleLabel.font = [UIFont systemFontOfSize:13.0];
       // but.backgroundColor = [UIColor redColor];
        but.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 0, 0);
        [butt setTitleColor:[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(addClick_storeCodeerweima) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:butt];
        [butt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(but.mas_right).offset(10);
            make.top.equalTo(cell.mas_top).offset(32);
            make.width.equalTo(@130);
            make.height.equalTo(@50);
            
        }];
        
        //显示最右边的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    
    
    return cell;
}
#define mark如何获取二维码示例
- (void)addClick_storeCodeerweima{
    
    if (self.b == YES) {

                _scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                _scro.backgroundColor = [UIColor grayColor];
                _scro.delegate = self;
        _scro.bouncesZoom = NO;
                _scro.showsVerticalScrollIndicator = YES;
                _scro.showsHorizontalScrollIndicator = YES;
                //_scro.scrollEnabled = YES;
              [self.scro addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(signlign:)]];
                _scro.alpha = 1.0;
                _scro.tag = 1;
        
                [self.view addSubview:self.scro];
       

        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _viewBack.backgroundColor = [UIColor grayColor];
        _viewBack.alpha = 1.0;
        _viewBack.tag = 1;
        
        [self.scro addSubview:_viewBack];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.imageView = [[UIImageView alloc]init];
            self.imageView.image = [UIImage imageNamed:@"register-10.png"];

            CGFloat imH = _imageView.image.size.height / 3;
            CGFloat imW = _imageView.image.size.width / 3;
            

            self.imageView.userInteractionEnabled = YES;
            
            self.imageView.frame = CGRectMake(0, 0, imW, imH);

            _scro.contentSize = CGSizeMake(0, imH);
            
            [self.viewBack addSubview:_imageView];

            
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
- (void)signlign:(UITapGestureRecognizer *)sender{

    [self.scro removeFromSuperview];

}

- (void)magnifyImageeee{
    
 
}
- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view{
    NSLog(@"iiiiiii");

    
        [self.scro removeFromSuperview];
 
    return YES;
}

#define mark点击空白处图片消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if (_viewBack.tag == 0) {
        
       // [_scro removeFromSuperview];
        NSLog(@"00000");
       [_viewBack removeFromSuperview];

    }
    
    if (_scro.tag == 0) {
        [_scro removeFromSuperview];
    }
    
    if (_scro.tag == 1  && _viewBack.tag == 1) {
        [_scro removeFromSuperview];
        [_viewBack removeFromSuperview];
    }
    
    
    NSLog(@"dgfnghnghfmj");


}
#define mark微信二维码示例
- (void)addClick_storeCode{
    
    if (self.b == YES) {

        
        NSLog(@"11111");
        
        
        //  UIWindow *window=[UIApplication sharedApplication].keyWindow;
        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _viewBack.backgroundColor = [UIColor grayColor];
        _viewBack.alpha = 1.0;
        _viewBack.tag = 0;
        
        [self.view addSubview:_viewBack];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.imageView = [[UIImageView alloc]init];
            self.imageView.image = [UIImage imageNamed:@"register-08.jpg"];
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
            
            //
            //            self.tap2  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scroclick)];
            //
            //            [self.scro addGestureRecognizer:self.tap];
            
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
- (void)magnifyImageee{
    
  //  [TWSJAvatarBrowser showImage:self.imageView];//调用方法
}
#define mark店铺招牌
- (void)addClick_signButton{

    
    if (self.b == YES) {

        
        NSLog(@"11111");

        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _viewBack.backgroundColor = [UIColor grayColor];
        _viewBack.alpha = 1.0;
        _viewBack.tag = 0;
        
        [self.view addSubview:_viewBack];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.imageView = [[UIImageView alloc]init];
            self.imageView.image = [UIImage imageNamed:@"register-09.png"];
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
- (void)magnifyImagee{

   // [TWSJAvatarBrowser showImage:self.imageView];//调用方法
}

#define mark店铺标识示例 --------
- (void)addClick{
    
    
    if (self.b == YES) {
        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _viewBack.backgroundColor = [UIColor grayColor];
        _viewBack.alpha = 1.0;
        _viewBack.tag = 0;
        
        [self.view addSubview:_viewBack];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.imageView = [[UIImageView alloc]init];
            self.imageView.image = [UIImage imageNamed:@"011.jpg"];
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
#define mark店铺标识放大方法 ----------
- (void)magnifyImageeyt
{

  ///  [self]

}
- (void)scroclick{

    [self.scro removeFromSuperview];
}
- (void)viewBackclick{
    NSLog(@"666");
    
    [self.viewBack removeFromSuperview];


}


#define mark店铺标识照片选择 ---------
- (void)makeindfierButton:(UIButton *)sender{
    
    
    self.currentBtn = 0;
    
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
            
            NSLog(@"11返回");
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

    NSLog(@"22返回");


}
#define mark店铺招牌图标照片 -------
- (void)SignmakeButton:(UIButton *)sender{

    self.currentBtn = 1;

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
            NSLog(@"33返回");
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
NSLog(@"44返回");

}
#define mark微信二维码图标照片
- (void)codeMakeButton:(UIButton *)sender{
    
    self.currentBtn =2;

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
            NSLog(@"55返回");
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
    NSLog(@"66返回");

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    headerImage = info[@"UIImagePickerControllerEditedImage"];
    
   
    
    if (self.currentBtn == 0) {

        [_indfierButton setImage:headerImage forState:UIControlStateNormal];
NSLog(@"77返回");
        

    }else if (self.currentBtn == 1){
    
        [_signButton setImage:headerImage forState:UIControlStateNormal];
       
        NSLog(@"99返回");
    
    }else if (self.currentBtn == 2){
NSLog(@"88返回");
        [_codeButton setImage:headerImage forState:UIControlStateNormal];

        
    }
    
    NSData * dataImage = UIImageJPEGRepresentation(headerImage, 0.3);
    
    [self uploadVoiceWithData:dataImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
 
    NSLog(@"00返回");
  
    
}

#define mark图片以字典方式上传方法
- (void)uploadVoiceWithData:(NSData *)data{
    
    
  
    NSMutableDictionary *dicd = [[NSMutableDictionary alloc] init];
    [dicd setObject:[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"file"];

//  http://www.ejoydg.com/api-upload_pic.html
    
    //  http://www.tianview.com/api-upload_pic.html
    NSString * urls = [[NSString stringWithFormat:@"%@",UPLOADURL]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    self.sessionManager  = [AFHTTPSessionManager manager];
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
       self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];

     [SVProgressHUD showWithStatus:@"上传中......"];
    
  [self.sessionManager POST:urls parameters:dicd progress:^(NSProgress * _Nonnull uploadProgress) {
    
      
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
      NSData * data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
      NSLog(@"responseString:%@",responseString);
     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
      NSLog(@"diccccc:%@",dic);
      
      if ([[NSString stringWithFormat:@"%@",dic[@"errcode"]] isEqualToString:@"0"]) {
          //[self createAlertView:@"上传成功"];
          [self dismisss];
      }
      
      if (dic[@"data"]) {
          if (self.currentBtn == 0) {
              [pramDic addEntriesFromDictionary:@{@"logo":dic[@"data"]}];
              NSLog(@"logo:%@",pramDic);
          }else if (self.currentBtn == 1){
              [pramDic addEntriesFromDictionary:@{@"banner":dic[@"data"]}];
              NSLog(@"banner:%@",pramDic);
          }else if (self.currentBtn == 2){
          [pramDic addEntriesFromDictionary:@{@"weixin_qrcode":dic[@"data"]}];
              NSLog(@"weixin_qrcode:%@",pramDic);
          }
          
          
      }else {
          [self SentientbeingspromptboxView:@"上传失败!"];
         // NSLog(@"上传失败");
      }
      
      //移除指示器
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"error:%@",error);
  }];
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 44;
    }else if (indexPath.row == 1){
        return 80;
    }else if (indexPath.row == 2){
        return 80;
    }else if (indexPath.row == 3){
        return 70;
    }

    return 0;
}

//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
