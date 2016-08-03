//
//  BaseController.m
//  HonGuMircoShop
//
//  Created by 张耀文 on 15/9/11.
//  Copyright (c) 2015年 张耀文. All rights reserved.
//

#import "BaseController.h"
#import "UIBarButtonItem+Extension.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backAction) image:@"back"];
    [self createNavbar];
}

- (void)backAction
{
 
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)createNavbar
{
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 64)];
    [navView setBackgroundColor:KMainColor];
    [self.view addSubview:navView];
    
    //2.登录按钮
    UIButton * backbButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 24, 60, 40)];
    [backbButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //    [backbButton setBackgroundColor:[UIColor blueColor]];
    [backbButton setImageEdgeInsets:UIEdgeInsetsMake(7, 17, 7, 17)];
    [self.view addSubview:backbButton];
    
    
    _titleNameLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-50, 35, 100, 20)];
    [_titleNameLable setTextColor:[UIColor whiteColor]];
    [_titleNameLable setFont:[UIFont systemFontOfSize:15]];
    [_titleNameLable setTextAlignment:1];
    [navView addSubview:_titleNameLable];
}

-(void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    [_titleNameLable setText:_titleName];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark 提示黑窗

- (void)createAlertView:(NSString *)text
{
    [successAlert removeFromSuperview];
    // self.view.frame.size.width/2 - 130, self.view.frame.size.height/2-100, 260, 85
    successAlert = [[UILabel alloc]initWithFrame:
                             CGRectMake(self.view.frame.size.width/2 - 130, self.view.frame.size.height/2-100, 290, 85)];
    successAlert.textColor = [UIColor whiteColor];
    successAlert.textAlignment = 1;
    successAlert.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.7];
    [successAlert.layer setCornerRadius:3];
    [successAlert.layer setMasksToBounds:YES];
    [successAlert setText:text];
    [successAlert setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:successAlert];
    
    [UIView animateWithDuration:0.4 animations:^{
        successAlert.transform = CGAffineTransformMakeScale(0.6, 0.6);
    } completion:^(BOOL finished) {
        //慢慢变透明，然后消失
        [UIView animateWithDuration:3
                         animations:^{
                             successAlert.alpha = 0;
                         }];
        [successAlert performSelector:@selector(removeFromSuperview)withObject:nil afterDelay:3];

    }];
}




@end
