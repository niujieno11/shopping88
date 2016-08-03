//
//  HeaderFooterView.m
//  易简大观
//
//  Created by kevin on 16/6/29.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import "HeaderFooterView.h"
#import "Order.h"
@implementation HeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        //    Headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        //    [Headview setClipsToBounds:YES];
//                    self.backgroundColor = [UIColor blackColor];
        _xianLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 2, 15)];
        _xianLabel.backgroundColor = [UIColor colorWithRed:226/255.0 green:142/255.0 blue:186/255.0 alpha:1];
        [self.contentView addSubview:_xianLabel];
        _dingdanLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_xianLabel.frame) +5, 10, 50, 20)];
        _dingdanLabel.text = @"订单号:";
        _dingdanLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
        
        [self.contentView addSubview:_dingdanLabel];
        _haoLabel= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_dingdanLabel.frame) +5, 10, 200, 20)];

        _haoLabel.font = [UIFont fontWithName:@"ArialMT" size:15];
        
        [self.contentView addSubview:_haoLabel];
        UILabel *jiaoXian = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, [UIScreen mainScreen].bounds.size.width - 20, 1)];
        jiaoXian.backgroundColor= [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [self.contentView addSubview:jiaoXian];
        
    }
    return self;
}
//- (void)headFuZhi:(GoodsModel *)good{
//    self.haoLabel.text = good.goods_sn;
////    NSLog(@"good.goods_sn == %@",good.goods_sn);
//}

 

@end
