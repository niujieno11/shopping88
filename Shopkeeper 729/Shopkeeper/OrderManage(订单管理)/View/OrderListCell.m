//
//  OrderListCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "OrderListCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"

@implementation OrderListCell

- (void)awakeFromNib {
    // Initialization code
    [_changePriceBt.layer setCornerRadius:4];
    [_changePriceBt setTitleColor:KMainColor forState:UIControlStateNormal];
    [_changePriceBt.layer setBorderWidth:0.5];
    [_changePriceBt.layer setBorderColor:KMainColor.CGColor];
}

-(void)setModel:(GoodsModel *)model
{
    [_goodsImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , model.goods_img]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    _goodsNameLable.text = model.goods_name;
    
    _priceLable.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    _gongHuoLable.text = [NSString stringWithFormat:@" 供货价：￥%@",model.fenxiao_price];
    
    _timeLable.text = [NSString stringWithFormat:@"供货价：￥%@",model.goods_price];
    
    CGSize size =[_gongHuoLable.text sizeWithFont:[UIFont systemFontOfSize:11] maxSize:CGSizeMake(MAXFLOAT, 18)];
    [_gongHuoLable setFrame:CGRectMake(165, 83, size.width+4, 18)];
    [_gongHuoLable.layer setCornerRadius:5];
    [_gongHuoLable clipsToBounds];
    
    _changePriceBt.indexPath = model.cellIndexPath;

}
@end
