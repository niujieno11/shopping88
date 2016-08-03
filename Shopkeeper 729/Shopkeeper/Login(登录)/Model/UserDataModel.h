//
//  UserDataModel.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/5.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataModel : NSObject

@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * ID_img;
@property (nonatomic, copy) NSString * ID_img2;
@property (nonatomic, copy) NSString * add_time;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * admin_id;
@property (nonatomic, copy) NSString * area_id;
@property (nonatomic, copy) NSString * area_id_name;
@property (nonatomic, copy) NSString * banner;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * city_name;
@property (nonatomic, copy) NSString * flag;
@property (nonatomic, copy) NSString * goods_number;
@property (nonatomic, copy) NSString * handheld_ID_img;
@property (nonatomic, copy) NSString * index_set;
@property (nonatomic, copy) NSString * is_authenticate;
@property (nonatomic, copy) NSString * is_guarantee;
@property (nonatomic, copy) NSString * is_shipping;
@property (nonatomic, copy) NSString * is_shop;
@property (nonatomic, copy) NSString * last_login_time;
@property (nonatomic, copy) NSString * last_update_name;
@property (nonatomic, copy) NSString * last_update_time;
@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * lng;
@property (nonatomic, copy) NSString * logo;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * mod_id;
@property (nonatomic, copy) NSString * mod_key;
@property (nonatomic, copy) NSString * op_logs;
@property (nonatomic, copy) NSString * openid;
@property (nonatomic, copy) NSString * paiming;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * province_name;
@property (nonatomic, copy) NSString * seller_name;
@property (nonatomic, copy) NSString * store_alias;
@property (nonatomic, copy) NSString * store_code;
@property (nonatomic, copy) NSString * store_tools;
@property (nonatomic, copy) NSString * store_type;
@property (nonatomic, copy) NSString * store_type_name;
@property (nonatomic, copy) NSString * stores_id;                   //店铺ID
@property (nonatomic, copy) NSString * stores_name;
@property (nonatomic, copy) NSString * tpl_id;
@property (nonatomic, copy) NSString * tpl_id_name;
@property (nonatomic, copy) NSString * truename;
@property (nonatomic, copy) NSString * up_type;
@property (nonatomic, copy) NSString * weixin_qrcode;

@end
