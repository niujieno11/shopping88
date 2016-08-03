//
//  CashRecordsController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/18.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashRecordsModel.h"

@interface CashRecordsController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
}



@end
