//
//  AddCustomerController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/11.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCustomerController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    UIButton * _currentSelectButton;
    NSMutableArray * _tableArr;
    
    
    NSString * _sifitStr;
    NSString * _sifitStr2;

    
    UITableView * _tableView;
}

@end
