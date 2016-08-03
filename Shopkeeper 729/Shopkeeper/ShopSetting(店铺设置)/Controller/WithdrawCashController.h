//
//  WithdrawCashController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/25.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawCashCell.h"

@interface WithdrawCashController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    
    UITableView * _tableView;
    
}


@end
