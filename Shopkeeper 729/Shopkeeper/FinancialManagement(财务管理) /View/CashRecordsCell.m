//
//  CashRecordsCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/18.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "CashRecordsCell.h"
#import "NSString+Extension.h"

@implementation CashRecordsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(CashRecordsModel *)model
{
    
    //注册时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [model.add_time doubleValue]];
    //时间按格式转字符串
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    _timeLable.text = confromTimespStr;
    
    //用户名
    CGSize size =[model.order_amount sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(MAXFLOAT, 18)];
    
    _cashRecordLable.text = [NSString stringWithFormat:@"%@", model.amount];

    
    _amountLable.text = [NSString stringWithFormat:@"余额:%@", model.order_amount];

    
    
}

@end
