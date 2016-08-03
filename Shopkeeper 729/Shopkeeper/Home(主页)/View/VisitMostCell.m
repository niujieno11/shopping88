//
//  VisitMostCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/4.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "VisitMostCell.h"

@implementation VisitMostCell

- (void)awakeFromNib {
    // Initialization code
    [_goodsImageView.layer setCornerRadius:35];
    _goodsImageView.clipsToBounds = YES;
}

-(void)setModel:(VisitMostModel *)model
{
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , model.goods_img]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];

    _nameLable.text = model.goods_name;
    
    _countLable.text = model.c;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [model.add_time doubleValue]];
    //时间按格式转字符串
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    _dateLable.text = confromTimespStr;
    
}

-(void)setModel2:(AddCustomerModel *)model2
{
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , model2.head_logo]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    
    _nameLable.text = model2.member_name;
    
    _countLable.text = model2.c;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [model2.add_time doubleValue]];
    //时间按格式转字符串
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    _dateLable.text = confromTimespStr;
}

@end
