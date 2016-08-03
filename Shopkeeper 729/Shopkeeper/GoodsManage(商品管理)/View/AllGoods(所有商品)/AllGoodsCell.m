//
//  AllGoodsCell.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "AllGoodsCell.h"
#import "UIImageView+WebCache.h"

@implementation AllGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if ((_cellIndexPath.row+1)%2==0 ) {//偶数
        [_photoImageView setFrame:CGRectMake(9.5, 5, 160, 160)];
        [_titleLable setFrame:CGRectMake(11, 168, 163, 30)];
        [_selectBt setFrame:CGRectMake(Main_Screen_Width/2/2/2-25, 240, 50, 50)];
        [_stockLable setFrame:CGRectMake(Main_Screen_Width/2-10-100, 255, 100, 20)];

    }else {
        [_photoImageView setFrame:CGRectMake(18, 5, 160, 160)];
        [_titleLable setFrame:CGRectMake(18, 168, 163, 30)];
        [_photoImageView setFrame:CGRectMake(18, 5, 160, 160)];
        [_selectBt setFrame:CGRectMake(Main_Screen_Width/2/2/2-25, 240, 50, 50)];
        [_stockLable setFrame:CGRectMake(Main_Screen_Width/2-10-100, 255, 100, 20)];

    }
    
}

-(void)displayWithMode:(GoodsModel *)goodsModel{
    
    self.selectBt.indexPath = _cellIndexPath;

    [_titleLable setText:goodsModel.goods_name];
    
    [_priceLable setText:[NSString stringWithFormat:@"￥%@",goodsModel.old_price]];
    [_gongHuoLable setText:[NSString stringWithFormat:@"供货价:￥%@",goodsModel.goods_price]];
    [_stockLable setText:[NSString stringWithFormat:@"库存:%@件",goodsModel.stock]];

    
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , goodsModel.goods_img]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    
    if ([goodsModel.ifSelect isEqualToString:@"YES"]) {
        self.selectBt.selected = YES;
    }else {
        self.selectBt.selected = NO;
    }
    
}
@end
