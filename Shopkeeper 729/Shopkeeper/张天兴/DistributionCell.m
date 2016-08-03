//
//  DistributionCell.m
//  易简大观
//
//  Created by kevin on 16/6/16.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import "DistributionCell.h"
#import "UIImageView+WebCache.h"
@implementation DistributionCell

- (void)awakeFromNib {
    // Initialization code
    self.contactLabel.text = @"联系方式:";
    self.loginLabel.text = @"注册时间:";
    self.loginLabel.font = [UIFont fontWithName:@"ArialMT" size:11];
    self.contactLabel.font = [UIFont fontWithName:@"ArialMT" size:11];



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fuzhi:(Distribution *)model{
    self.NameLabel.text = model.parent_id_name;
    self.NumberLabel.text = model.mobile;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.add_time intValue]];
    NSString *confrom = [formatter stringFromDate:date];
    self.DateLabel.text = confrom;
    NSString *strImage = [NSString stringWithFormat:@"http://www.tianview.com%@",model.head_logo];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:strImage]];
    NSLog(@"model.head_logo==%@",model.head_logo);
    self.MLabel.text = model.goods_num;
}

@end
