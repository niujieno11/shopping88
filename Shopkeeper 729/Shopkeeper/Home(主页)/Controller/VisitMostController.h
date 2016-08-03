//
//  VisitMostController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/29.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitMostController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    UIButton * _currentSelectButton;
    NSMutableArray * _tableArr;
    
    
    NSString * _sifitStr;
    
    UITableView * _tableView;
}


@end
