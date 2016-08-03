//
//  ShopCodeController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/25.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "ShopCodeController.h"
#import "UIImageView+WebCache.h"

@interface ShopCodeController ()

@end

@implementation ShopCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"店铺二维码";
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
    
    [dic setObject:@"erweimadp" forKey:@"type"];


//    [LCProgressHUD showLoading:@"加载中..."];
     [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGetQRCode Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kShopQRCode == %@",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
             [_shopQRCodeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage2 , dic[@"data"]]] placeholderImage:nil options:SDWebImageRetryFailed];
        }

        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
         [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];


}
@end
