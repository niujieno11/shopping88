//
//  WXApiRequestHandler.h
//  weixinpay
//
//  Created by TianView on 16/7/11.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"

@interface WXApiRequestHandler : NSObject

+ (BOOL)jumpToBizWebviewWithAppID:(NSString *)appID
                      Description:(NSString *)description
                        tousrname:(NSString *)tousrname
                           ExtMsg:(NSString *)extMsg;

+ (NSString *)jumpToBizPay;

@end
