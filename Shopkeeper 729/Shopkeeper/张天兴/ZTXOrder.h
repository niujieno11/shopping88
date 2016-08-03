//
//  ZTXOrder.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/18.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTXOrder : NSObject
//@property (nonatomic, strong) NSString *goods_sn;
@property (nonatomic, strong) NSString *mod_key;
@property (nonatomic, strong) NSString *mod_id;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *order_sn;
@property (nonatomic, strong) NSArray *goods_infoArr;

@end
