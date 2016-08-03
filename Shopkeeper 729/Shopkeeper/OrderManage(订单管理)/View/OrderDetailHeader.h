//
//  OrderDetailHeader.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/17.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface OrderDetailHeader : UITableViewHeaderFooterView

/** 订单编号 */
@property (nonatomic, strong) UILabel * orderSN;


/** 细分割线 */
@property (nonatomic, strong) UILabel * xiLineLable;

/** 数据模型 */
@property (nonatomic, strong) OrderListModel * model;

@end
