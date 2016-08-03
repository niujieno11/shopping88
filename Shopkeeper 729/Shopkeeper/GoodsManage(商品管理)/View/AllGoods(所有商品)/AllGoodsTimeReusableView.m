//
//  AllGoodsTimeReusableView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "AllGoodsTimeReusableView.h"

@implementation AllGoodsTimeReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setBackgroundColor:[UIColor redColor]];
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 20, Main_Screen_Width/2-25-80, 2)];
    [image1 setImage:[UIImage imageNamed:@"bianXian1"]];
    [self addSubview:image1];
    
    UIImageView * image2 = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width-25-( Main_Screen_Width/2-25-80), 20, Main_Screen_Width/2-25-80, 2)];
    [image2 setImage:[UIImage imageNamed:@"bianXian2"]];
    [self addSubview:image2];
    
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake( 0, 0, Main_Screen_Width, 44)];
    [_timeLable setFont:[UIFont systemFontOfSize:12]];
    [_timeLable setTextColor:RGBCOLOR(70, 70, 70)];
    [_timeLable setTextAlignment:1];
    [self addSubview:_timeLable];
    
}

-(void)setModel:(NewGoodsTimeListModel *)model
{
    _model = model;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [model.add_time doubleValue]];
    //时间按格式转字符串
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    _timeLable.text = [NSString stringWithFormat:@"%@ 新款 (%d)", confromTimespStr, model.goodsModelArr.count];
}

@end
