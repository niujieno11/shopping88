//
//  SimpleApp.m
//  Shopkeeper
//
//  Created by liu ben le on 16/7/15.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "SimpleApp.h"

@implementation SimpleApp

+(instancetype)danliPassValue
{
    static SimpleApp * simle =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        simle=[[SimpleApp alloc]init];
    });
    return simle;
}
@end
