//
//  CustomerManageController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/23.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerManageController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
}


@end
