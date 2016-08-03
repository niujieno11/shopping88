//
//  FinancialManagementCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/24.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinancialModel.h"

@interface FinancialManagementCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLable;


@property (nonatomic, strong) UILabel * yueLable;


@property (nonatomic, strong) UILabel * moneyLable;

/** 模型 */
@property (nonatomic, strong) FinancialModel * model;


@end
