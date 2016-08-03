//
//  DistributionDetailsController.h
//  易简大观
//
//  Created by kevin on 16/6/16.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTXOrder.h"
#import "OrderCellData.h"
#import "GoodsModel.h"
@interface DistributionDetailsController : BaseController<UITableViewDataSource, UITableViewDelegate>
{
    UIView * _headerView;
    NSString * _cellType;
    UIView *Headview;
    UIView *Hview;
    UIButton *aButton;
    UIButton *bButton;
    NSString *strC;
    NSString *strPhone;
}
@property (nonatomic, assign) NSInteger numberID;
@property (nonatomic, strong) NSString *IDNumber;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contactLabel;//联系方式
@property (nonatomic, strong) UILabel *numberLabel;//电话
@property (nonatomic, strong) UILabel *salesMaLabel;//销售的钱数
@property (nonatomic, strong) UILabel *salesLabel;//销售额
@property (nonatomic, strong) UILabel *timeLabel;//注册时间
@property (nonatomic, strong) UILabel *timeMaLabel;
@property (nonatomic, strong) UILabel *commissionLabel;//佣金额
@property (nonatomic, strong) UILabel *commissionMalabel;//钱数
@property (nonatomic, strong) UITableView * tableView;

//@property (nonatomic, strong) UILabel *haoLabel;
@end
