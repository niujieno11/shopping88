//
//  ClassifyListController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/12.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "IndexPathBt.h"
#import "ShopButton.h"

@interface ClassifyListController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
    NSString * _urlTyleStr;
    UIButton * _currentSelectButton;
    
    UILabel * _sliderLable;

}

@property (nonatomic, copy) NSString * classID;

@property (nonatomic, copy) NSString * className;

@property (nonatomic, copy) NSString * ifMy;

@end
