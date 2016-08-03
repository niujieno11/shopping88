//
//  TodayVisitController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/9.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayVisitModel.h"

@interface TodayVisitController :  BaseController<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
    NSString * _siftStr;
    
}


@end
