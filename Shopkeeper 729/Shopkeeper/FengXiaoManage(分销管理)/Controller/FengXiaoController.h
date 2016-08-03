//
//  FengXiaoController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/23.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FengXiaoController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    UIButton * _currentSelectButton;
    NSMutableArray * _tableArr;
 
    NSString * _siftStr;
    NSString * _siftStr2;

    
    UITableView * _tableView;
}
@end
