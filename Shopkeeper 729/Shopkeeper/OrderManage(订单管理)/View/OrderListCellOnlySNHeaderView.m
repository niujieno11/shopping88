//
//  OrderListCellOnlySNHeaderView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "OrderListCellOnlySNHeaderView.h"

@implementation OrderListCellOnlySNHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _orderSN = [[UILabel alloc]init];
        [_orderSN setTextColor:RGBCOLOR(100, 100, 100)];
        [_orderSN setFont:[UIFont systemFontOfSize:11]];
        [self addSubview:_orderSN];
        
        _chuLineLable = [[UILabel alloc]init];
        [_chuLineLable setBackgroundColor:RGBCOLOR(230, 230, 230)];
        [self addSubview:_chuLineLable];
        
        _xiLineLable = [[UILabel alloc]init];
        [_xiLineLable setBackgroundColor:RGBCOLOR(230, 230, 230)];
        [self addSubview:_xiLineLable];
        
        
        _stateLineLable = [[UILabel alloc]init];
        [_stateLineLable setBackgroundColor:KMainColor];
        [self addSubview:_stateLineLable];
        
        _stateLable = [[UILabel alloc]init];
        [_stateLable setTextColor:RGBCOLOR(100, 100, 100)];
        [_stateLable setFont:[UIFont systemFontOfSize:11]];
        [_stateLable setHidden:YES];
        [_stateLineLable setHidden:YES];
        [self addSubview:_stateLable];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [_chuLineLable setFrame:CGRectMake(0, 0, Main_Screen_Width, 1.5)];
    [_orderSN setFrame:CGRectMake(18, 0, 200, 40)];
    [_stateLineLable setFrame:CGRectMake(Main_Screen_Width-80, 11, 1.5, 20)];
    [_stateLable setFrame:CGRectMake(Main_Screen_Width-70, 0, 130, 40)];
    [_xiLineLable setFrame:CGRectMake(18, 39.5, Main_Screen_Width-40, 0.5)];
    
}

-(void)setModel:(OrderListModel *)model
{
 
     _orderSN.text = [NSString stringWithFormat:@"订单号：%@",model.order_sn];
    
    
}


@end
