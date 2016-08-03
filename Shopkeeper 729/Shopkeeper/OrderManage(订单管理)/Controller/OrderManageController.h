//
//  OrderManageController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListView.h"
#import "OrderDetailController.h"


@interface OrderManageController : BaseController<OrderListViewDelegate>
{
    
    UIButton * _currentSelectButton;
    UIButton * _currentSelectButton2;

    //1.
    UIView * _transactionView;
    OrderListView * _allView;
    OrderListView * _waitPayView;
    OrderListView * _waitSendView;
    OrderListView * _waitReceiveView;
    OrderListView * _waitEvelution;

    
    OrderListView * _finishView;
    
    //3.
    UIView * _failureView;
    OrderListView * _refundMoneyView;
    OrderListView * _customerfailureView;


}
@end
