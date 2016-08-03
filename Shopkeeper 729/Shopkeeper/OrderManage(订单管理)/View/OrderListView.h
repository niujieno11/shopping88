//
//  OrderListView.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePriceView.h"
#import "OrderListModel.h"
#import "GoodsModel.h"

typedef NS_ENUM(NSUInteger, ViewType) {
    AllStatesViewType,
    WaitPayViewType,
    WaitSendViewType,
    WaitReceivedViewType,
    WaitEvaluateViewType,
    FinishViewType,
    RefundMoneyViewType,
    FailureViewType,
};

@protocol OrderListViewDelegate <NSObject>

-(void)orderListViewPushWith:(ViewType)viewType OrderListModel:(OrderListModel *)orderListModel;

@end

@interface OrderListView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    ViewType _currentViewType;
}

@property (nonatomic, assign) id<OrderListViewDelegate>delegate;


@property (nonatomic, strong)  ChangePriceView * changePriceView;


- (instancetype)initWithFrame:(CGRect)frame ViewType:(ViewType)viewType;

@end
