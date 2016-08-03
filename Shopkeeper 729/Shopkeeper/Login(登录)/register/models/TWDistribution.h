//
//  TWDistribution.h
//  Shopkeeper
//
//  Created by liu ben le on 16/7/7.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWDistribution : NSObject
@property (nonatomic, copy)NSString * stores_id;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)distributionWithDictionary:(NSDictionary *)dic;

@end
