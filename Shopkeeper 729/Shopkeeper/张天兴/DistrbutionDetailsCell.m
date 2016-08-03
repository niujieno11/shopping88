//
//  DistrbutionDetailsCell.m
//  yijiandaguan
//
//  Created by kevin on 16/6/15.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import "DistrbutionDetailsCell.h"
#import "GoodsModel.h"
#import "UIImageView+WebCache.h"
@implementation DistrbutionDetailsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fuzhiCell:(GoodsModel *)model{
//    self.SizeLabel.text = model.
    self.NumNameLabel.text = model.goods_number;
//    NSLog(@"model.goods_number ==%@",model.goods_number);
    
    self.Address.text = model.goods_name;
//    NSLog(@"model.goods_number ==%@",model.goods_name);
    self.StyNameLabel.text = model.weight;
    self.SizeNameLabel.text = model.gender;
    self.MoneyLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    NSString *str = [NSString stringWithFormat:@"http://www.tianview.com/%@",model.goods_img];
    [self.Imager sd_setImageWithURL:[NSURL URLWithString:str]];
}
@end
