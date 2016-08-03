//
//  TodayVisitCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/9.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "TodayVisitCell.h"
#import "UIImageView+WebCache.h"

@implementation TodayVisitCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(TodayVisitModel *)model
{
    //头像
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , model.head_logo]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    
    _nameLable.text = model.member_name;
    
    _comFromLable.text = [NSString stringWithFormat:@"来自：%@",model.ip_from];
    
    //注册时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    //时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [model.add_time doubleValue]];
    //时间按格式转字符串
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    _dateLable.text = confromTimespStr;

}

@end
