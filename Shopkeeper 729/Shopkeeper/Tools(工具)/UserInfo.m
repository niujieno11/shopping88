//
//  UserInfo.m
//  Yogo
//
//  Created by 张耀文 on 15/8/11.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

#import "UserInfo.h"
#import "LoginController.h"
#import "ZYWNavigationController.h"

static UserInfo *userInfoSingleton = nil;


@implementation UserInfo



+(BOOL)userInfoIfUserLoginOrImmediatelyLoginWithSuccess:(SuccessBlcok)success;
{
    if ([UserInfo shareUserInfoSingleton].userInfoDic[@"id"]) {
        success([UserInfo shareUserInfoSingleton].userInfoDic[@"id"]);
        return YES;
    }else {
        LoginController *login = [[LoginController alloc] init];
        ZYWNavigationController *nav = [[ZYWNavigationController alloc]initWithRootViewController:login];
//        login.success = success;
        [[UserInfo appRootViewController] presentViewController:nav animated:YES completion:nil];
        return NO;
    }
}


+(UserInfo *)shareUserInfoSingleton
{
    @synchronized(self){
        if (!userInfoSingleton) {
            userInfoSingleton = [[UserInfo alloc]init];
        }
        return userInfoSingleton;
    }
}


+ (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+(NSDictionary *)userInfoGetUser;
{
    if ([UserInfo shareUserInfoSingleton].userInfoDic) {
        return [UserInfo shareUserInfoSingleton].userInfoDic;
    }else {
         NSLog(@"用户尚未登录");
        return nil;
    }
}

+(void)autoLoginAction
{
        
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 0 .api
    [dic setObject:@"mobile.front.login" forKey:@"service"];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    // 1.账号
    [dataDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userAccount"] forKey:@"account"];
    
    // 2.密码
    [dataDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"] forKey:@"password"];
    
    // 4.mac地址
            [dataDic setObject:[UUID getUserDefaultsUUID] forKey:@"devMac"];
    
//    [dic setObject:[dataDic JSONRepresentation] forKey:@"data"];
    
//    NSLog(@"longindic == %@",dic);
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:nil Parameters:dic style:kConnectPostType success:^(id dic) {
        
          NSLog(@"autoLoginActiondic == %@",dic);

        if ([[dic objectForKey:@"status"] integerValue] == 1) {
            
            NSDictionary *userDic = dic[@"object"][@"memberInfo"];
         
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            
            [userDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSString *str = [NSString stringWithFormat:@"%@",obj];
                if (![str isEqualToString:@"<null>"]) {
                    [dict setObject:obj forKey:key];
                }
            }];
            //        NSLog(@"dict == %@",dict);
            
            [UserInfo shareUserInfoSingleton].userInfoDic = dict;
            
            NSLog(@"[UserInfo shareUserInfoSingleton].userInfoDic == %@",[UserInfo shareUserInfoSingleton].userInfoDic);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SetShoppingCartCount" object:nil];

        }
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);

    }];
}

@end
