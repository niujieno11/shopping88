//
//  UnShelveView.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/12.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "IndexPathBt.h"
#import "ShopButton.h"

@protocol UnShelveViewDelegate <NSObject>

-(void)unShelveViewPushWith:(NSString *)goods_id;

@end

@interface UnShelveView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray * _tableArr;
    UITableView * _tableView;
    
}

@property (nonatomic, assign) id<UnShelveViewDelegate>delegate;

@end
