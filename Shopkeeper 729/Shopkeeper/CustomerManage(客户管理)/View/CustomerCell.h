//
//  CustomerCell.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/23.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

@interface CustomerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *registerTimeLable;

@property (weak, nonatomic) IBOutlet UILabel *lastVistTimeLable;

@property (weak, nonatomic) IBOutlet UILabel *vistCountLable;

@property (weak, nonatomic) IBOutlet UILabel *typeLable;


@property (nonatomic, copy) NSString * type;


/** 名字 */
@property (nonatomic, strong) UILabel * nameLable;

/** 来自 */
@property (nonatomic, strong) UILabel * comeFrome;

@property (nonatomic, strong) CustomerModel * model;



@end
