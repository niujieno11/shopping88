//
//  OrderListCellHeaderView.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexPathBt.h"
#import "OrderListModel.h"

@interface OrderListCellHeaderView : UITableViewHeaderFooterView

/** 红色竖线 */
@property (nonatomic, strong) UILabel * redLineLabl;

/** 状态 */
@property (nonatomic, strong) UILabel * stateLineLable;
@property (nonatomic, strong) UILabel * stateLable;


/** 下单时间 */
@property (nonatomic, strong) UILabel * timeLable;

/** 订单编号 */
@property (nonatomic, strong) UILabel * orderSN;

/** 修改价格/查物流按钮 */
@property (nonatomic, strong) IndexPathBt * functionButton;

/** 粗分割线 */
@property (nonatomic, strong) UILabel * chuLineLable;

/** 细分割线 */
@property (nonatomic, strong) UILabel * xiLineLable;

/** 数据模型 */
@property (nonatomic, strong) OrderListModel * model;

@end
