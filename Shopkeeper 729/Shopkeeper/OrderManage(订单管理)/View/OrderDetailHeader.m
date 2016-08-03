//
//  OrderDetailHeader.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/17.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "OrderDetailHeader.h"

@implementation OrderDetailHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [_orderSN setFrame:CGRectMake(18, 10, 130, 40)];
    [_xiLineLable setFrame:CGRectMake(18, 49.5, Main_Screen_Width-30, 0.5)];
    
}

-(void)setModel:(OrderListModel *)model
{
    _orderSN.text = [NSString stringWithFormat:@"订单号：%@",model.order_sn];
}


@end
