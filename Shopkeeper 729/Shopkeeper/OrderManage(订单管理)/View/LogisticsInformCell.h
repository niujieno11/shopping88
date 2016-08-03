//
//  LogisticsInformCell.h
//  YunNanBuy
//
//  Created by 张耀文 on 15/11/26.
//  Copyright © 2015年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryModel.h"

@interface LogisticsInformCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *instructionsLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *instru2Image;

@property (weak, nonatomic) IBOutlet UILabel *contentLanle;

@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@property (strong, nonatomic)  DeliveryModel *deliveryModel;

@end
