//
//  NewGoodsTimeListModel.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "NewGoodsTimeListModel.h"
#import "GoodsModel.h"

@implementation NewGoodsTimeListModel

-(void)toModelWithDict:(NSDictionary *)dict
{
    if (dict[@"key"]) {
        self.add_time = dict[@"key"];
    }
    
    if ([dict[@"list"] isKindOfClass:[NSArray class]]) {
        NSArray * arr = dict[@"list"];
        if (arr.count > 0) {
            self.goodsModelArr = [GoodsModel objectArrayWithKeyValuesArray:arr];
        }
    }
}
@end
