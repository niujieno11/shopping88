//
//  FinancialManagementCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/24.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "FinancialManagementCell.h"
#import "NSString+Extension.h"

@implementation FinancialManagementCell

- (void)awakeFromNib {
    _yueLable = [[UILabel alloc]init];
    [_yueLable setTextColor:RGBCOLOR(70, 70, 70)];
    [_yueLable setFont:[UIFont systemFontOfSize:13]];
    _yueLable.text = @"余额";
    [self addSubview:_yueLable];
    
    _moneyLable = [[UILabel alloc]init];
    [_moneyLable setTextColor:RGBCOLOR(190, 0, 0)];
    [_moneyLable setFont:[UIFont systemFontOfSize:11]];
    [self addSubview:_moneyLable];
}

-(void)setModel:(FinancialModel *)model
{
    
  
    
    //注册时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [model.add_time doubleValue]];
    //时间按格式转字符串
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    _dateLable.text = [NSString stringWithFormat:@"%@       %@",confromTimespStr, model.money];
    
    
    //用户名
    CGSize size =[model.amount sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(MAXFLOAT, 18)];
    _moneyLable.text = model.amount;
    [_moneyLable setFrame:CGRectMake(Main_Screen_Width-15-size.width, 0, size.width, 44)];
    [_yueLable setFrame:CGRectMake(Main_Screen_Width-15-size.width-40, 0, 40, 44)];
    
    
}
@end
