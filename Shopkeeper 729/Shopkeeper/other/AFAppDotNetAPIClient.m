//
//  AFAppDotNetAPIClient.m
//  TeaWorld
//
//  Created by Zhangwenybx on 15-3-27.
//  Copyright (c) 2015年 天问科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFAppDotNetAPIClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"https://wap.baidu.com/";

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClientWithfailure:(FailureBlcok)failure {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
//        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        
//        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            switch (status) {
//                case AFNetworkReachabilityStatusReachableViaWWAN:
//                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
//                    
//                    break;
//                    
//                case AFNetworkReachabilityStatusReachableViaWiFi:
//                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
//                    break;
//                case AFNetworkReachabilityStatusNotReachable:
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoWlan" object:nil];
//                    
//                    NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
//                    break;
//                default:
//                    break;
//            }
//        }];
//        [_sharedClient.reachabilityManager startMonitoring];
    });
    
    _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
    _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NoWlan" object:nil];
                
                NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                
                failure(@"nowaln");
                
                break;
            default:
                break;
        }
    }];
    [_sharedClient.reachabilityManager startMonitoring];
    return _sharedClient;
}

+ (instancetype)sharedClientlogin {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
          });
    
    _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
    _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                [UserInfo shareUserInfoSingleton].networkStatus = @"AFNetworkReachabilityStatusReachableViaWWAN";

                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                [UserInfo shareUserInfoSingleton].networkStatus = @"AFNetworkReachabilityStatusReachableViaWiFi";

                break;
            case AFNetworkReachabilityStatusNotReachable:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NoWlan" object:nil];
                
//                NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                [UserInfo shareUserInfoSingleton].networkStatus = @"AFNetworkReachabilityStatusNotReachable";

                break;
            default:
                break;
        }
    }];
    [_sharedClient.reachabilityManager startMonitoring];
    return _sharedClient;
}


@end
