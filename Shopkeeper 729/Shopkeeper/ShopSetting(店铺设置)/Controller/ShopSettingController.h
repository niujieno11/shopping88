//
//  ShopSettingController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/24.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopSettingController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    UIImageView * _shopLogo;
}


@end
