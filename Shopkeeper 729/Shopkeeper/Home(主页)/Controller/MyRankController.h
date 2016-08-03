//
//  MyRankController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/29.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRankModel.h"

@interface MyRankController :  UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
}


@end
