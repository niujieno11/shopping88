//
//  MyRankCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/1.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRankModel.h"

@interface MyRankCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLable;

@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@property (weak, nonatomic) IBOutlet UILabel *ifTodayLable;

@property (weak, nonatomic) IBOutlet UILabel *rankLable;

@property (weak, nonatomic) IBOutlet UILabel *visitLable;


/** 模型 */
@property (nonatomic, strong) MyRankModel * model;


@end
