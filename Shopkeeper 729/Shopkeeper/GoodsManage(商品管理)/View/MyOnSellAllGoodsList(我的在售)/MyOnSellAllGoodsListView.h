//
//  MyOnSellAllGoodsListView.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "IndexPathBt.h"
#import "ShopButton.h"

@protocol MyOnSellAllGoodsListViewDelegate <NSObject>

-(void)myOnSellAllGoodsListViewPushWith:(NSString *)goods_id;

@end

@interface MyOnSellAllGoodsListView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
}

@property (nonatomic, assign) id<MyOnSellAllGoodsListViewDelegate>delegate;

@end
