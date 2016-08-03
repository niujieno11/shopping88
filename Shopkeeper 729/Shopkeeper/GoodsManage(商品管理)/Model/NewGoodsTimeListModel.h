//
//  NewGoodsTimeListModel.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewGoodsTimeListModel : NSObject

@property (nonatomic, copy) NSString * add_time;

/** 商品模型数组 */
@property (nonatomic, strong) NSArray * goodsModelArr;

-(void)toModelWithDict:(NSDictionary *)dict;

@end
