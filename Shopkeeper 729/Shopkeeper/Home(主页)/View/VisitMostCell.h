//
//  VisitMostCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/4.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitMostModel.h"
#import "AddCustomerModel.h"

@interface VisitMostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *countLable;

@property (weak, nonatomic) IBOutlet UILabel *dateLable;

/** model */
@property (nonatomic, strong) VisitMostModel * model;
@property (nonatomic, strong) AddCustomerModel * model2;


@end
