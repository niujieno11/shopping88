//
//  AllGoodsCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "IndexPathBt.h"

@interface AllGoodsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet IndexPathBt *selectBt;

@property (weak, nonatomic) IBOutlet UILabel *stockLable;

@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@property (weak, nonatomic) IBOutlet UILabel *gongHuoLable;


@property (nonatomic, strong) NSIndexPath * cellIndexPath;


-(void)displayWithMode:(GoodsModel *)goodsModel;

@end
