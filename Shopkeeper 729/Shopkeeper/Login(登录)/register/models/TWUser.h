//
//  TWUser.h
//  TWCompare
//
//  Created by TianView on 16/6/22.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWUser : NSObject
@property (nonatomic, copy)NSString * errcode;
@property (nonatomic, copy)NSString * errmsg;
@property (nonatomic, copy)NSString * data;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)userWithDictionary:(NSDictionary *)dic;

@end
