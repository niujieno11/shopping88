//
//  AFAppDotNetAPIClient.h
//  TeaWorld
//
//  Created by Zhangwenybx on 15-3-27.
//  Copyright (c) 2015年 天问科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface AFAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClientWithfailure:(FailureBlcok)failure;
+ (instancetype)sharedClientlogin;
@end
