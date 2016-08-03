//
//  DistrbutionDetailsCell.h
//  yijiandaguan
//
//  Created by kevin on 16/6/15.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface DistrbutionDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Imager;
@property (weak, nonatomic) IBOutlet UILabel *Address;

@property (weak, nonatomic) IBOutlet UILabel *StyleLabel;//类型
@property (weak, nonatomic) IBOutlet UILabel *StyNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *SizeLabel;//尺寸
@property (weak, nonatomic) IBOutlet UILabel *SizeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;//数量
@property (weak, nonatomic) IBOutlet UILabel *NumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *MoneyLabel;

- (void)fuzhiCell:(Order *)model;

@end
