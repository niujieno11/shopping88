//
//  LogisticsInformCell.m
//  YunNanBuy
//
//  Created by 张耀文 on 15/11/26.
//  Copyright © 2015年 张耀文. All rights reserved.
//

#import "LogisticsInformCell.h"

@implementation LogisticsInformCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setDeliveryModel:(DeliveryModel *)deliveryModel
{
    [self.contentLanle setText:deliveryModel.context];
    [self.dateLable setText:deliveryModel.time];
}
@end
