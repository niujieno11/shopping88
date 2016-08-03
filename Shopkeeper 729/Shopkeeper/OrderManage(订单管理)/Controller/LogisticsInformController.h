//
//  LogisticsInformController.h
//  YunNanBuy
//
//  Created by 张耀文 on 15/11/26.
//  Copyright © 2015年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryModel.h"

@interface LogisticsInformController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
    DeliveryModel *  _deliveryModel;
    
}

@property(nonatomic , copy) NSString * order_bh;

@end
