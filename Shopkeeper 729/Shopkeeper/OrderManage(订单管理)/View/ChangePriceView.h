//
//  ChangePriceView.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/16.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@protocol ChangePriceViewDeletate <NSObject>

-(void)changePriceViewChangeSuccess;

@end

@interface ChangePriceView : UIView
{
    UITableView * _changeView;
    
    UITextField * _text;
}

@property (nonatomic, strong) GoodsModel * goodsModel;

@property (nonatomic, assign) BOOL ifShow;

@property (nonatomic, assign) id<ChangePriceViewDeletate>delegete;

-(void)viewApper;

-(void)viewDisapper;


@end
