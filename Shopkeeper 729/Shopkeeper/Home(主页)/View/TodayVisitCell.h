//
//  TodayVisitCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/9.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayVisitModel.h"

@interface TodayVisitCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *comFromLable;

 
@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@property (weak, nonatomic) IBOutlet UIImageView *erCodeImageView;

/**  */
@property (nonatomic, strong) TodayVisitModel * model;



@end
