//
//  TWDistribution.m
//  Shopkeeper
//
//  Created by liu ben le on 16/7/7.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "TWDistribution.h"

@implementation TWDistribution
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        
        _stores_id = dic[@"stores_id"];
    }
    return self;
}
+ (instancetype)distributionWithDictionary:(NSDictionary *)dic{

    return [[[self class]alloc]initWithDictionary:dic];
}

@end
