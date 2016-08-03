//
//  OrderListCellHeaderView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "OrderListCellHeaderView.h"
#import "NSString+Extension.h"

@implementation OrderListCellHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {

        _redLineLabl = [[UILabel alloc]init];
        [_redLineLabl setBackgroundColor:KMainColor];
        [self addSubview:_redLineLabl];
        
        _timeLable = [[UILabel alloc]init];
        [_timeLable setTextColor:RGBCOLOR(20, 20, 20)];
        [_timeLable setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:_timeLable];
        
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
    [_redLineLabl setFrame:CGRectMake(17, 15, 1.5, 20)];
    [_timeLable setFrame:CGRectMake(22, 0, 150, 48.5)];
    [_chuLineLable setFrame:CGRectMake(0, 48.5, Main_Screen_Width, 1.5)];
    [_orderSN setFrame:CGRectMake(18, 50, 200, 40)];
    [_stateLineLable setFrame:CGRectMake(Main_Screen_Width-80, 59, 1.5, 20)];
    [_stateLable setFrame:CGRectMake(Main_Screen_Width-70, 50, 130, 40)];
    [_xiLineLable setFrame:CGRectMake(18, 89.5, Main_Screen_Width-40, 0.5)];

}

-(void)setModel:(OrderListModel *)model
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [model.add_time doubleValue]];
    //时间按格式转字符串
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    _timeLable.text = [NSString stringWithFormat:@"%@ 下单",confromTimespStr];
    _orderSN.text = [NSString stringWithFormat:@"订单号：%@",model.order_sn];
    
//    CGSize size =[_orderSN.text sizeWithFont:[UIFont systemFontOfSize:11] maxSize:CGSizeMake(MAXFLOAT, 18)];
    
}


@end
