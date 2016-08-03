//
//  MyRankCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/1.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "MyRankCell.h"
#import "NSString+Extension.h"

@implementation MyRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MyRankModel *)model
{
    NSDictionary * dic = [model.add_time distanceTimeeWithBeforeTime:[model.add_time doubleValue]];
    
    if (dic[@"today"]) {
        _ifTodayLable.text =dic[@"today"];
        [_ifTodayLable setHidden:NO];
        [_dayLable setHidden:YES];
        [_dateLable setHidden:YES];

    }else {
        _dayLable.text =dic[@"day"];
        [_dayLable setHidden:NO];
        _dateLable.text =dic[@"year"];
        [_dateLable setHidden:NO];
        [_ifTodayLable setHidden:YES];

    }
    
    
    _rankLable.text = [NSString stringWithFormat:@"我的排名：%@",model.number];
    
    _visitLable.text = [NSString stringWithFormat:@"%@",model.c];
    
}

@end
