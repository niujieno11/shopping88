//
//  WXApiManager.h
//  weixinpay
//
//  Created by TianView on 16/7/11.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>

@optional


- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

@end

@interface WXApiManager : NSObject<WXApiDelegate>
@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;
@end
