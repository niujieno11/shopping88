//
//  DistributionCell.h
//  易简大观
//
//  Created by kevin on 16/6/16.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Distribution.h"
@interface DistributionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *MLabel;



-(void)fuzhi:(Distribution *)model;
@end
