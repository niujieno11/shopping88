//
//  OrderListCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "IndexPathBt.h"

@interface OrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageVIew;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLable;

@property (strong, nonatomic) UILabel *gongHuoLable;

@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
 

@property (nonatomic, strong) GoodsModel * model;

@property (weak, nonatomic) IBOutlet IndexPathBt *changePriceBt;

@end
