//
//  MyOnSellAllGoodsListCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "IndexPathBt.h"

@interface MyOnSellAllGoodsListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet IndexPathBt *selectButton;

@property (weak, nonatomic) IBOutlet IndexPathBt *downButton;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageVIew;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLable;

@property (strong, nonatomic) UILabel *gongHuoLable;

@property (weak, nonatomic) IBOutlet UILabel *xiaoShouJiaLable;

@property (weak, nonatomic) IBOutlet UILabel *addTimeLable;

@property (nonatomic, strong) GoodsModel * model;

@property (nonatomic, strong) NSIndexPath * cellIndexPath;

@end
