//
//  AppDelegate.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "ZYWNavigationController.h"
#import "WXApiManager.h"
#import "SimpleApp.h"
#import "WXApi.h"
#import "HomeController.h"

#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //微信注册
    [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"demo 2.0"];

    
    [self.window setRootViewController:[[ZYWNavigationController alloc]initWithRootViewController:[[LoginController alloc]init]]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
//    
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//    
//    
//    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@",resultDic);
                                                  }];
    }else{
    
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    
    }
    
    if ([url.host isEqualToString:@"platformapi"]){ //支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }

    
//    if ([url.host isEqualToString:@"safepay"]) {
//        
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处就是在这个方法里面处理跟callback一样的逻辑
//            NSString *message = @"";
//            switch([[resultDic objectForKey:@"resultStatus"] integerValue])
//            {
//                    NSString * passValue =nil;
//                    SimpleApp * sim = [SimpleApp  danliPassValue];
//                    passValue = sim.backmeath;
//                    NSLog(@"ceshi:%@",passValue);
//                    
//                    
////                    if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
////                        HomeController * home = [[HomeController alloc]init];
////                        
////                        [self ]
////                    }
// 
////                case 9000:message = @"订单支付成功"; break;
////                case 8000:message = @"正在处理订单"; break;
////                case 4000:message = @"订单支付失败"; break;
////                case 6001:message = @"用户中途取消"; break;
////                case 6002:message = @"网络连接错误"; break;
////                default:message = @"未知错误";
//            }
//            
//            UIAlertController *aalert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
//            [aalert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
//            UIViewController *root = self.window.rootViewController;
//            [root presentViewController:aalert animated:YES completion:nil];
//            
//            NSLog(@"result = %@",resultDic);
//        }];
//    }
//    else
//    {
//
//    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
