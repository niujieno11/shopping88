//
//  UnShelveCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/12.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "UnShelveCell.h"

@implementation UnShelveCell

- (void)awakeFromNib {
    // Initialization code
    _gongHuoLable = [[UILabel alloc]init];
    [_gongHuoLable setBackgroundColor:RGBCOLOR(100, 100, 100)];
    [_gongHuoLable setTextColor:[UIColor whiteColor]];
    [_gongHuoLable setFont:[UIFont systemFontOfSize:11]];
    [_gongHuoLable.layer setCornerRadius:5];
    [_gongHuoLable clipsToBounds];
    [self addSubview:_gongHuoLable];
}


-(void)setModel:(GoodsModel *)model
{
    if ([model.ifSelect isEqualToString:@"YES"]) {
        self.selectButton.selected = YES;
    }else {
        self.selectButton.selected = NO;
    }
    self.selectButton.indexPath = _cellIndexPath;
    
    [_goodsImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , model.goods_img]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    _goodsNameLable.text = model.goods_name;
    
    _xiaoShouJiaLable.text = [NSString stringWithFormat:@"￥%@",model.old_price];
    _gongHuoLable.text = [NSString stringWithFormat:@" 供货价：￥%@",model.fenxiao_price];
    
    _addTimeLable.text = model.add_timex;
    
    CGSize size =[_gongHuoLable.text sizeWithFont:[UIFont systemFontOfSize:11] maxSize:CGSizeMake(MAXFLOAT, 18)];
    [_gongHuoLable setFrame:CGRectMake(165, 83, size.width+4, 18)];
    [_gongHuoLable.layer setCornerRadius:5];
    [_gongHuoLable clipsToBounds];
}

@end
