//
//  FinancialManagementController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/24.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "FinancialManagementController.h"
#import "FinancialFlowController.h"
#import "CashRecordsController.h"


@interface FinancialManagementController ()

@end

@implementation FinancialManagementController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.titleName = @"财务管理";
    
    NSArray * arr = @[@"财务流水", @"提现", @"提现记录"];
    for (int i = 0; i< arr.count; i++) {
        UIButton * bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 64+i*50, Main_Screen_Width, 50)];
        [bt addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTag:(100+i)];
        [self.view addSubview:bt];
        
        UILabel * l = [[UILabel alloc]initWithFrame:CGRectMake(18, 64+i*50, 100, 50)];
        [l setText:arr[i]];
        [l setFont:[UIFont systemFontOfSize:15]];
        [l setTextColor:[UIColor blackColor]];
        [self.view addSubview:l];
        
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+50+i*50, Main_Screen_Width, 0.5)];
        [line setBackgroundColor:RGBCOLOR(220, 220, 220)];
        [self.view  addSubview:line];
        
    }
}


-(void)btAction:(UIButton *)bt
{
    if (bt.tag == 100) {
        FinancialFlowController * f = [[FinancialFlowController alloc]init];
        [self.navigationController pushViewController:f animated:YES];
    }else  if (bt.tag == 101) {
        UIAlertView * a =[[UIAlertView alloc]initWithTitle:@"暂不支持APP提现请到微信管理界面操作"message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [a show];
    }else {
        CashRecordsController * c = [[CashRecordsController alloc]init];
        [self.navigationController pushViewController:c animated:YES];
    }
}

@end
