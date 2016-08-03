//
//  ZYWNavigationController.m
//  BuoBeiBao
//
//  Created by 张耀文 on 15/6/3.
//  Copyright (c) 2015年 张耀文. All rights reserved.
//

#import "ZYWNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface ZYWNavigationController ()

@end

@implementation ZYWNavigationController

+ (void)initialize
{
 
 
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil];
    
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSFontAttributeName : [UIFont systemFontOfSize:15],
                                  }];
    
    [bar setBarTintColor:KMainColor];
     
    
    // 5.设置状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
}


    

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;

        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
