//
//  GoodsClassifyModel.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/12.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsClassifyModel : NSObject

@property (nonatomic, copy) NSString * add_time;
@property (nonatomic, copy) NSString * class_code;
@property (nonatomic, copy) NSString * flag;
@property (nonatomic, copy) NSString * goods_class_id;
@property (nonatomic, copy) NSString * goods_class_name;
@property (nonatomic, copy) NSString * last_update_name;
@property (nonatomic, copy) NSString * last_update_time;
@property (nonatomic, copy) NSString * mod_id;
@property (nonatomic, copy) NSString * mod_key;
@property (nonatomic, copy) NSString * pid;
@property (nonatomic, copy) NSString * pid_name;
@property (nonatomic, copy) NSString * sort_by;
/** 子类数组 */
@property (nonatomic, strong) NSArray * childArr;

-(void)toModelWithDict:(NSDictionary *)dict;

@end
