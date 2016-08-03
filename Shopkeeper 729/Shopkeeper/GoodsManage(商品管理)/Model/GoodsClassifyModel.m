//
//  GoodsClassifyModel.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/12.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "GoodsClassifyModel.h"

@implementation GoodsClassifyModel

-(void)toModelWithDict:(NSDictionary *)dict
{
 
    self.add_time = dict[@"add_time"];
    self.class_code = dict[@"class_code"];
    self.flag = dict[@"flag"];
    self.goods_class_id = dict[@"goods_class_id"];
    self.goods_class_name = dict[@"goods_class_name"];
    self.last_update_name = dict[@"last_update_name"];
    self.mod_id = dict[@"mod_id"];
    self.mod_key = dict[@"mod_key"];
    self.pid = dict[@"pid"];
    self.pid_name = dict[@"pid_name"];
    self.sort_by = dict[@"sort_by"];
    
    if ([dict[@"child"] isKindOfClass:[NSArray class]]) {
        self.childArr = [GoodsClassifyModel objectArrayWithKeyValuesArray:dict[@"child"]];
    }

}
@end
