//
//  TWUser.m
//  TWCompare
//
//  Created by TianView on 16/6/22.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWUser.h"

@implementation TWUser
- (instancetype)initWithDictionary:(NSDictionary *)dic{

    if (self = [super init]) {
        _errcode = dic[@"errcode"];
        _errmsg = dic[@"errmsg"];
        _data = dic[@"data"];
        
    }
    
    return self;
}
+ (instancetype)userWithDictionary:(NSDictionary *)dic{

    return [[[self class]alloc]initWithDictionary:dic];
}


@end
