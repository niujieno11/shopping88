//
//  FengXiaoCodeController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/25.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "FengXiaoCodeController.h"
#import "UIImageView+WebCache.h"

@interface FengXiaoCodeController ()

@end

@implementation FengXiaoCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"分销二维码";

    [self netWork];
}

-(void)createNavbar
{
    
}
-(void)netWork
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    [dic setObject:@"erweimafx" forKey:@"type"];

    
    [LBProgressHUD showHUDto:self.view animated:YES];
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGetQRCode Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kFengXiaoQRCode == %@",dic);

        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            [_fengXiaoQRCodeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage2 , dic[@"data"]]] placeholderImage:nil options:SDWebImageRetryFailed];
        }
        
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
    
}

@end
