//
//  TWDescController.m
//  TWCompare
//
//  Created by TianView on 16/6/28.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWDescController.h"
#import "Masonry.h"
#import "AppDelegate.h"

#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "TWUserModel.h"
#import "TWAgreeController.h"
#import "SVProgressHUD.h"
#
#import "AFHTTPSessionManager.h"
#import "UIButton+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "TWDistribution.h"
#import "Reachability.h"
#import "TWSweepController.h"
#import "UIBarButtonItem+Extension.h"

@interface TWDescController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIWebViewDelegate,UIWebViewDelegate>

@property (nonatomic, strong)UILabel * titleLabel;//分销标题
@property (nonatomic, strong)UILabel * descLabel;//确认为分销
@property (nonatomic, strong)UIButton * nextButton;
@property (nonatomic, strong)UIImageView * imagev;//图像
//UIImagePickerController是一个控制器，但是此类不能被继承
@property (nonatomic,strong)UIImagePickerController * imagePickerController;
@property (nonatomic,strong)NSData * imageData;
@property (nonatomic,strong)UIWebView * myWeb;

@property (nonatomic, strong)NSMutableArray * arr;
@property (nonatomic, strong)NSArray * array;
@property (nonatomic, strong)NSMutableDictionary * aryDic;

@property (nonatomic, strong)AFHTTPSessionManager * sessionManager;

@end

@implementation TWDescController

-(void)createNavbar
{
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    
    [self reachNotNet];
    
    _arr = [[NSMutableArray alloc]init];
    
    self.title = @"分销";
    
    _aryDic = [[NSMutableDictionary alloc]init];
    

    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.view.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];

    
    
    _imagev = [[UIImageView alloc]init];
    _imagev.layer.cornerRadius = 50;
    _imagev.layer.masksToBounds = YES;
    [_imagev setImage:[UIImage imageNamed:@"moren-1"]];
    _imagev.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_imagev];
    
    [_imagev mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(90);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:20 weight:2.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(220);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 80, 50));
    }];
    
    
    _descLabel = [[UILabel alloc]init];
    
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.numberOfLines = 0;
    _descLabel.textColor = [UIColor colorWithRed:129.0/255.0 green:129.0/255.0 blue:129.0/255.0 alpha:1.0];
    _descLabel.font = [UIFont systemFontOfSize:19.0];
    
    
    [self.view addSubview:_descLabel];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(250);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 60, 90));
    }];
    
    
    
    _nextButton = [[UIButton alloc]init];
    _nextButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    _nextButton.layer.cornerRadius = 10;
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextButtoning) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];
    
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-120);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 40, 44));
        
    }];
}
#define mark4判断网络
- (void)reachNotNet{

    Reachability * r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    NetworkStatus  status = [r currentReachabilityStatus];
    
    if (status == NotReachable) {
        //无网络
        [self NotNet];
        
    }else{
    
    //有网络
        
        [self Load];
        
    
    }



}
#define mark无网络
- (void)NotNet{


    [self SentientbeingspromptboxView:@"请检查网络是否正常!"];

}
#define mark有网络
- (void)Load{


    self.sessionManager  = [AFHTTPSessionManager manager];
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //NSString * str = @"http://www.tianview.com/api-ydz_getstoreinfo_byid.html?id=3";
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    
    NSString * ur =[NSString stringWithFormat:@"http://www.tianview.com/api-ydz_getstoreinfo_byid.html?id=%@",_story_id];
    
    NSLog(@"ur:%@",ur);
    
    

       
        [self.sessionManager GET:ur parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            self.aryDic = dic[@"data"];
            
            NSString * imageStr = [NSString stringWithFormat:@"http://www.tianview.com"];
            //判断是否是以http开头
            if ([dic[@"data"][@"logo"] hasPrefix:@"http://"]) {
                NSString *  imageStr11 = [NSString stringWithFormat:@"%@",dic[@"data"][@"logo"]];
                
                NSURL * url = [NSURL URLWithString:imageStr11];
                
                NSData * data = [NSData dataWithContentsOfURL:url];
                _imagev.image = [UIImage imageWithData:data];
                
                
            }else{
                
                NSString * imageStr22 = [NSString stringWithFormat:@"%@%@",imageStr,dic[@"data"][@"logo"]];
                NSURL * url = [NSURL URLWithString:imageStr22];
                NSData * data = [NSData dataWithContentsOfURL:url];
                _imagev.image = [UIImage imageWithData:data];
            }
            
            _titleLabel.text = [NSString stringWithFormat:@"成为%@的分销商",dic[@"data"][@"stores_name"]];
            NSString * msg = [NSString stringWithFormat:@"请确认成为%@的分销商,确认后再进行‘下一步’操作",dic[@"data"][@"stores_name"]];
            
            _descLabel.text = msg;
            
            [SVProgressHUD dismiss];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];

        

    
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
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-200);
        
    }];
}

- (void)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#define mark3下一步到开店协议走的方法
- (void)nextButtoning{

    TWAgreeController * agree = [[TWAgreeController alloc]init];
    
    agree.story_id_1 = _story_id;
    
    agree.storetype =_storetype;
    
    NSLog(@"agree.storetype:%@",agree.storetype);
    NSLog(@"_storetype:%@",_storetype);
    
    NSLog(@"agree.story_id_1:%@, agree.storetype:%@",agree.story_id_1,agree.storetype);
    
    [self.navigationController pushViewController:agree animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

@end
