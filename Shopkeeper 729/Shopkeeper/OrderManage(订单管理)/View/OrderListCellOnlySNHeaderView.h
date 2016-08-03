//
//  OrderListCellOnlySNHeaderView.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface OrderListCellOnlySNHeaderView : UITableViewHeaderFooterView


/** 状态 */
@property (nonatomic, strong) UILabel * stateLineLable;
@property (nonatomic, strong) UILabel * stateLable;


/** 订单编号 */
@property (nonatomic, strong) UILabel * orderSN;

/** 粗分割线 */
@property (nonatomic, strong) UILabel * chuLineLable;

/** 细分割线 */
@property (nonatomic, strong) UILabel * xiLineLable;

/** 数据模型 */
@property (nonatomic, strong) OrderListModel * model;

@end
