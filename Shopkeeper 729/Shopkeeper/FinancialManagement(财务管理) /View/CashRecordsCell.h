//
//  CashRecordsCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/18.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashRecordsModel.h"

@interface CashRecordsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cashRecordLable;

@property (weak, nonatomic) IBOutlet UILabel *amountLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;


@property (nonatomic, strong) CashRecordsModel * model;

@end
