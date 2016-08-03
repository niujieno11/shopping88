//
//  UserInfo.h
//  Yogo
//
//  Created by 张耀文 on 15/8/11.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataModel.h"

typedef void (^SuccessBlcok)(id user_id);

typedef void (^RefreshSuccessBlcok)();


@interface UserInfo : NSObject

//判断用户是否登录
+(BOOL)userInfoIfUserLoginOrImmediatelyLoginWithSuccess:(SuccessBlcok)success;


//获取用户信息
+(NSDictionary *)userInfoGetUser;

@property (nonatomic, strong) NSDictionary * userInfoDic;
@property (nonatomic, strong) UserDataModel * userDataModel;
//@property (nonatomic, strong) MemberBasicInfoModel * memberBasicInfoModel;
@property (nonatomic, copy) NSString * cheCount;
@property (nonatomic, copy) NSString * networkStatus;


+(UserInfo *)shareUserInfoSingleton;

+(void)autoLoginAction;


@end
