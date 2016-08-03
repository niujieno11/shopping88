//
//  OrderDetailController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/17.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
#import "GoodsModel.h"
#import "OrderListCell.h"
#import "OrderDetailHeader.h"
#import "OrderListView.h"
#import "GoodsModel.h"
#import "IndexPathBt.h"
#import "GoodsModel.h"


@interface OrderDetailController : BaseController<UITableViewDataSource, UITableViewDelegate, ChangePriceViewDeletate>
{
    
//    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
    NSIndexPath * _currentSelectIndexPath;
    
    UILabel * _amountLable;
    
    BOOL _flg;
        
}

@property (nonatomic, assign) ViewType currentViewType;

@property (nonatomic, strong) OrderListModel * orderListModel;

@property (nonatomic, strong)  ChangePriceView * changePriceView;


@end
