//
//  OrderListModel.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject

@property (nonatomic, copy) NSString * add_time;
@property (nonatomic, copy) NSString * add_timex;
@property (nonatomic, copy) NSString * amount;
@property (nonatomic, copy) NSString * comment_status;
@property (nonatomic, copy) NSString * credit;

@property (nonatomic, copy) NSString * fenxiao_amount;
@property (nonatomic, copy) NSString * flag;
@property (nonatomic, copy) NSString * goods_amount;
@property (nonatomic, strong) NSArray * goods_info;

@property (nonatomic, copy) NSString * goods_number;
@property (nonatomic, copy) NSString * last_update_name;
@property (nonatomic, copy) NSString * last_update_time;
@property (nonatomic, copy) NSString * member_id;
@property (nonatomic, copy) NSString * member_name;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * mod_id;
@property (nonatomic, copy) NSString * mod_key;

@property (nonatomic, strong) NSArray * op_logs;

@property (nonatomic, copy) NSString * order_return_id;
@property (nonatomic, copy) NSString * order_return_sn;
@property (nonatomic, copy) NSString * order_sn;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * orders_id;
@property (nonatomic, copy) NSString * pay_amount;
@property (nonatomic, copy) NSString * pay_code;
@property (nonatomic, copy) NSString * pay_status;
@property (nonatomic, copy) NSString * pay_time;
@property (nonatomic, copy) NSString * r_member_id;
@property (nonatomic, copy) NSString * r_member_name;
@property (nonatomic, copy) NSString * receive_address;
@property (nonatomic, copy) NSString * receive_mobile;
@property (nonatomic, copy) NSString * receive_name;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * return_logs;
@property (nonatomic, copy) NSString * return_status;
@property (nonatomic, copy) NSString * return_type;
@property (nonatomic, copy) NSString * shipping_status;

@property (nonatomic, copy) NSString * shipping_store_id;
@property (nonatomic, copy) NSString * shipping_store_name;
@property (nonatomic, copy) NSString * shipping_time;
@property (nonatomic, copy) NSString * sort_by;
@property (nonatomic, copy) NSString * store_id;
@property (nonatomic, copy) NSString * store_name;
@property (nonatomic, copy) NSString * youfei;
@property (nonatomic, copy) NSString * statu;

@property (nonatomic, copy) NSString * youfei_id;
@property (nonatomic, copy) NSString * kuaidigongsi;
@property (nonatomic, copy) NSString * compty;
@property (nonatomic, copy) NSString * post_num;
 

@end
