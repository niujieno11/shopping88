//
//  BaseController.h
//  HonGuMircoShop
//
//  Created by 张耀文 on 15/9/11.
//  Copyright (c) 2015年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController

{
    UILabel * _titleNameLable;
    
    UILabel *successAlert;
}

@property (nonatomic, copy) NSString * titleName;


- (void)backAction;

- (void)createAlertView:(NSString *)text;

-(void)createNavbar;

@end
