//
//  CustomerCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/23.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "CustomerCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"

@implementation CustomerCell

- (void)awakeFromNib {
    // Initialization code
    
    _nameLable = [[UILabel alloc]init];
    [_nameLable setTextColor:RGBCOLOR(70, 70, 70)];
    [_nameLable setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_nameLable];
    
    _comeFrome = [[UILabel alloc]init];
    [_comeFrome setTextColor:RGBCOLOR(90, 90, 90)];
    [_comeFrome setFont:[UIFont systemFontOfSize:11]];
    [self addSubview:_comeFrome];
    
    [_headerImageView.layer setCornerRadius:30];
    _headerImageView.clipsToBounds = YES;
    
}



-(void)setModel:(CustomerModel *)model
{
    //头像
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , model.head_logo]] placeholderImage:[UIImage imageNamed:@"user"] options:SDWebImageRetryFailed];

    //用户名
    CGSize size =[model.true_name sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(MAXFLOAT, 18)];
    _nameLable.text = model.true_name;
    [_nameLable setFrame:CGRectMake(85, 20, size.width+3, 15)];
    [_comeFrome setFrame:CGRectMake(85+size.width+3, 83, size.width+4, 18)];

    if ([self.type isEqualToString:@"fenxiao"]) {
        //联系方式
        _registerTimeLable.text = [NSString stringWithFormat:@"联系方式:%@", model.mobile];
        _typeLable.text = @"出售";
    }else {
        //最后浏览
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"YYYY/MM/dd"];
        //时间戳转时间
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [model.last_login_time doubleValue]];
        //时间按格式转字符串
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        _registerTimeLable.text = [NSString stringWithFormat:@"注册时间:%@", confromTimespStr];
         _typeLable.text = @"浏览";
        _vistCountLable.text = model.c;
    }
   
    
    //最后浏览
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
    [formatter1 setDateFormat:@"YYYY/MM/dd HH:mm"];
    //时间戳转时间
    NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970: [model.last_login_time doubleValue]];
    //时间按格式转字符串
    NSString *confromTimespStr1 = [formatter1 stringFromDate:confromTimesp1];
    _lastVistTimeLable.text = [NSString stringWithFormat:@"最后浏览:%@", confromTimespStr1];
    
    
    
    
}

@end
