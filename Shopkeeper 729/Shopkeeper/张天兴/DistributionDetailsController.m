//
//  DistributionDetailsController.m
//  易简大观
//
//  Created by kevin on 16/6/16.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import "DistributionDetailsController.h"
#import "DistrbutionDetailsCell.h"
#import "DistributionCell.h"
#import "Distribution.h"
#import "UIImageView+WebCache.h"
#import "HeaderFooterView.h"
@interface DistributionDetailsController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) NSMutableArray *headDataSource;
//@property (nonatomic, strong) NSMutableArray *cellDataSource;
@end

@implementation DistributionDetailsController

//-(NSMutableArray *)headDataSource{
//    if (!_headDataSource) {
//        self.headDataSource = [NSMutableArray arrayWithCapacity:0];
//    }
//    return self.headDataSource;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    numberID = 905;
    strC = @"http://www.tianview.com";
    _dataSource = [NSMutableArray array];
    _headDataSource = [NSMutableArray array];
    [self parsingData];

//    _cellDataSource = [NSMutableArray array];
     _cellType = @"order";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    

    
//    [self.tableView registerClass:[Headview class] forHeaderFooterViewReuseIdentifier:@"head"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)parsingData{
//    NSString *netStr = [NSString stringWithFormat:@"%@/api-ydz_fenxiao_orders.html?member_id=%ld",strC,(long)_numberID];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)_numberID] forKey:@"member_id"];
    
       [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kFenxiaoOrders Parameters:dic style:kConnectGetType success:^(id dict) {
        NSLog(@"fenxiao_orders == %@", dict[@"data"]);
        NSString * errcodeStr = [NSString stringWithFormat:@"%@",dict[@"errcode"]];
        NSDictionary *dic = dict[@"data"];
        NSString *strImag = [NSString stringWithFormat:@"http://www.tianview.com%@",dic[@"head_logo"]];
        [self.img sd_setImageWithURL:[NSURL URLWithString:strImag]];
        
        NSDictionary *memberdic = dic[@"member"];
        self.numberLabel.text = memberdic[@"mobile"];
        //                    strPhone = @"15887163348";
        self.nameLabel.text = memberdic[@"member_name"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[memberdic[@"add_time"] intValue]];
        NSString *confrom = [formatter stringFromDate:date];
        self.timeMaLabel.text = confrom;
        self.salesMaLabel.text = dic[@"zonge"];
        self.commissionMalabel.text = dic[@"yongjin"];

        //判断取出来的是不是数组类型
        if ([dict[@"data"][@"orders"] isKindOfClass:[NSArray class]]) {
            NSArray * orders = dict[@"data"][@"orders"];
            NSLog(@" orders == %@",orders);
            if (orders.count == 0) {
                [self createAlertView:@"没有订单！"];
                
            }else{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.labelText = @"加载中...";

                if ([errcodeStr isEqualToString:@"0"]) {
                    [_headDataSource removeAllObjects];
                    NSArray *arrayOrders = dic[@"orders"];
                    for (NSDictionary *ordersdic in arrayOrders) {
                        ZTXOrder * orders = [[Order alloc]init];
                        [orders setValuesForKeysWithDictionary:ordersdic];
                        
                        NSMutableArray * goodsInfoArr = [NSMutableArray array];
                        for (NSDictionary * goodsInfoDic in ordersdic[@"goods_info"]) {
                            GoodsModel * goodsMode = [[GoodsModel alloc]init];
                            [goodsMode setValuesForKeysWithDictionary:goodsInfoDic];
                            [goodsInfoArr addObject:goodsMode];
                        }
                        orders.goods_infoArr = goodsInfoArr;
                        [self.headDataSource addObject:orders];
                        
                    }
                    
                    NSLog(@"self.headDataSource==%@",self.headDataSource);
                    
                    
                    [self.tableView reloadData];
                    
                    
                    
                    
                }

                                
            
        }
    }
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([error isKindOfClass:[NSString class]]) {
            
            
        }else {
            NSLog(@"error -- %@",error);
            
        }
    }];

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if ([_cellType isEqualToString:@"order"]) {
        return _headDataSource.count + 1;
    }else {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }else{
        if ([_cellType isEqualToString:@"order"]) {
            ZTXOrder * orders = self.headDataSource[section-1];
            return orders.goods_infoArr.count;
        }else{
            return self.dataSource.count;
        }
        
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_cellType isEqualToString:@"order"]) {
        static NSString * cellIndetifier = @"DistrbutionDetailsCell";
        DistrbutionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DistrbutionDetailsCell" owner:self options:nil] lastObject];
            
        }
        
         ZTXOrder * orders = self.headDataSource[indexPath.section-1];
        NSLog(@"orders == %@",orders);

        
        [cell fuzhiCell:orders.goods_infoArr[indexPath.row]];
        return cell;
    }else {
        static NSString *cellIndetifier = @"DistributionCell";
        DistributionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DistributionCell" owner:self options:nil]lastObject];
        }
        [cell fuzhi:self.dataSource[indexPath.row]];

        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if (section == 0) {
         if ([_cellType isEqualToString:@"order"]) {
             return 170;
         }else {
             return 230;
         }
        
     }else {
         if ([_cellType isEqualToString:@"order"]) {
             return 40;
         }else {
             return 0;
         }
         
     }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
    return 1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, [UIScreen mainScreen].bounds.size.width, 1)];
    label.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    return label;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (!Hview) {
            [self HviewChuang];
            [self chuangjianHview];
        }
       
        
        return Hview;
    }else {
      
        if ([_cellType isEqualToString:@"order"]) {
            
            static NSString * cellIndetifier = @"HeaderFooterView";
            HeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIndetifier];
            if (!footerView) {
                footerView = [[HeaderFooterView alloc] initWithReuseIdentifier:cellIndetifier];
            }
            ZTXOrder * orderr = _headDataSource[section-1];
                footerView.haoLabel.text = orderr.order_sn;
             
            return footerView;
        }else{
            return nil;
        }
        
        
    }
}

- (void)HviewChuang{
    Hview = [[UIView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 300)];
    [Hview setClipsToBounds:YES];
    
    //    [self.tableView addSubview:view];
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 70, 70)];
    self.img.layer.cornerRadius = 35;
    self.img.layer.masksToBounds = YES;
    [Hview addSubview:self.img];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame) + 5, 10, [UIScreen mainScreen].bounds.size.width - 80, 30)];
//    self.nameLabel.text = order.true_name;
    self.nameLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
    [Hview addSubview:self.nameLabel];
    self.contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame) + 5,  CGRectGetMaxY(self.nameLabel.frame) +5, 50, 30)];
    //        self.contactLabel.backgroundColor = [UIColor redColor];
    self.contactLabel.font = [UIFont fontWithName:@"ArialMT" size:10];
    self.contactLabel.text = @"联系方式：";
    [Hview addSubview:self.contactLabel];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contactLabel.frame) , CGRectGetMaxY(self.nameLabel.frame)+5 , 70, 30)];
    self.numberLabel.font = [UIFont fontWithName:@"ArialMT" size:10];
    
    [Hview addSubview:self.numberLabel];
    
    self.salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame) + 5,  CGRectGetMaxY(self.contactLabel.frame) +5, 35, 25)];
    self.salesLabel.text = @"销售额:";
    self.salesLabel.font = [UIFont fontWithName:@"ArialMT" size:10];
    [Hview addSubview:self.salesLabel];
    self.salesMaLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.salesLabel.frame)+5,  CGRectGetMaxY(self.numberLabel.frame)+2,70, 30)];
    self.salesMaLabel.font = [UIFont fontWithName:@"ArialMT" size:15];
    self.salesMaLabel.textColor = [UIColor redColor];
    [Hview addSubview:self.salesMaLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.numberLabel.frame) + 5, CGRectGetMaxY(self.numberLabel.frame)-30, 50, 30)];
    self.timeLabel.font = [UIFont fontWithName:@"ArialMT" size:10];
    self.timeLabel.text = @"注册时间：";
    [Hview addSubview:self.timeLabel];
    
    self.commissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.salesMaLabel.frame) +10, CGRectGetMaxY(self.timeLabel.frame) + 5, 40, 25)];
    //        self.commissionLabel.backgroundColor = [UIColor redColor];
    self.commissionLabel.text = @"佣金额:";
    self.commissionLabel.font = [UIFont fontWithName:@"ArialMT" size:11];
    
    [Hview addSubview:self.commissionLabel];
    self.timeMaLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLabel.frame) +2, CGRectGetMaxY(self.numberLabel.frame)-30, 80, 30)];
    self.timeMaLabel.text = @"2016/03/28";
    self.timeMaLabel.font = [UIFont fontWithName:@"ArialMT" size:10];
    
    [Hview addSubview:self.timeMaLabel];
    self.commissionMalabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commissionLabel.frame) +10, CGRectGetMaxY(self.timeMaLabel.frame)+2, 80, 30)];
    self.commissionMalabel.text = @"2480.00";
    self.commissionMalabel.textColor = [UIColor redColor];
    self.commissionMalabel.font = [UIFont fontWithName:@"ArialMT" size:15];
    [Hview addSubview:self.commissionMalabel];
    UILabel *xianLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commissionMalabel.frame)+20, [UIScreen mainScreen].bounds.size.width, 2)];
    xianLabel.backgroundColor = [UIColor grayColor];
    [Hview addSubview:xianLabel];
    aButton = [UIButton buttonWithType:UIButtonTypeSystem];
    aButton.frame = CGRectMake(0, CGRectGetMaxY(xianLabel.frame), [UIScreen mainScreen].bounds.size.width/2, 40) ;
    [aButton setTitle:@"订单" forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
 
    [Hview addSubview:aButton];
    
    bButton = [UIButton buttonWithType:UIButtonTypeSystem];
    bButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, CGRectGetMaxY(xianLabel.frame), [UIScreen mainScreen].bounds.size.width/2, 40) ;
    [bButton setTitle:@"分销" forState:UIControlStateNormal];
    [bButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bButton.layer setBorderWidth:2];//设置边宽
    //设置按钮颜色
    //            CGColorSpaceRef colorSpaceRe = CGColorSpaceCreateDeviceRGB();
    //            CGColorRef colo = CGColorCreate(colorSpaceRe, (CGFloat[]){1,0,0,1});
    [bButton.layer setBorderColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor];
    
    [aButton setTintColor:[UIColor colorWithRed:217/255.0 green:69/255.0 blue:148/255.0 alpha:1]];
    [bButton setTintColor:[UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1]];
    [Hview addSubview:bButton];

}
- (void)chuangjianHview{
    _segment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"一级分销",@"二级分销",@"三级分销", nil]];
    [_segment setFrame:CGRectMake(10, CGRectGetMaxY(bButton.frame)+20, [UIScreen mainScreen].bounds.size.width - 20, 30)];
    [_segment setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
    [_segment setTintColor:[UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:1]];
    [_segment.layer setCornerRadius:4];
    [_segment.layer setBorderWidth:0.5];
    [_segment addTarget:self action:@selector(topSegmentAction:) forControlEvents:UIControlEventValueChanged];
    [_segment setSelectedSegmentIndex:0];
    _segment.layer.masksToBounds = YES;
    _segment.layer.cornerRadius = _segment.frame.size.height/2;
    [_segment setTitleTextAttributes:@{
                                       NSForegroundColorAttributeName :[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1]
                                       } forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:@{
                                       NSForegroundColorAttributeName : [UIColor colorWithRed:195/255.0 green:0/255.0 blue:114/255.0 alpha:1]
                                       } forState:UIControlStateSelected];
    [Hview addSubview:_segment];
    

}
- (void)topSegmentAction:(UISegmentedControl *)segment{
    UISegmentedControl *control = (UISegmentedControl *)segment;
    switch (control.selectedSegmentIndex) {
        case 0:
            
            [self snalyticalData:1];
            break;
        case 1:
            [self snalyticalData:2];

            break;
        case 2:
            [self snalyticalData:3];

            break;
        default:
            break;
    }
}

-(void)snalyticalData:(NSInteger)i {
    NSString *str = [NSString stringWithFormat:@"%@/api-ydz_getfenxiao.html?mobile=%@&level=%ld",strC,strPhone,(long)i];

    [NetWorkRequest netWorkRequestWithEnvironmentStr:str BaseURLStr:nil Parameters:nil style:kConnectGetType success:^(id dic) {
        NSLog(@"getfenxiao == %@", dic);
        
//        NSString * errcodeStr = [NSString stringWithFormat:@"%@",dic[@"errcode"]];
        NSArray *arr = dic[@"data"];
        
        if ([dic[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray * orders = dic[@"data"];
            if (orders.count == 0) {
                [self createAlertView:@"还没有下级分销！"];
        }else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"加载中...";
            Distribution *dis = [[Distribution alloc]init];
            [_dataSource removeAllObjects];
            
            for (NSDictionary *dic in arr) {
                [dis setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:dis];
            }
            
     

        }
            [self.tableView reloadData];
            
            //移除指示器
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(NSError *error) {
        
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([error isKindOfClass:[NSString class]]) {
            
            
        }else {
            NSLog(@"error -- %@",error);
            
        }
    }];
    }
     

-(void)buttonAction:(UIButton *)bt
{
    if ([bt.titleLabel.text isEqualToString:@"订单"]) {
        _cellType = @"order";
     
        [bButton.layer setBorderWidth:2];//设置边宽
        //设置按钮颜色
        //            CGColorSpaceRef colorSpaceRe = CGColorSpaceCreateDeviceRGB();
        //            CGColorRef colo = CGColorCreate(colorSpaceRe, (CGFloat[]){1,0,0,1});
        [bButton.layer setBorderColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor];
        
        [aButton setTintColor:[UIColor colorWithRed:217/255.0 green:69/255.0 blue:148/255.0 alpha:1]];
        [bButton setTintColor:[UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1]];
        [aButton.layer setBorderWidth:0];
        [self parsingData];

    }else {
        _cellType = @"fenxiao";
        [aButton.layer setBorderWidth:2];//设置边宽
        //设置按钮颜色
        [aButton.layer setBorderColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor];
        [aButton setTintColor:[UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1]];
        [bButton setTintColor:[UIColor colorWithRed:217/255.0 green:69/255.0 blue:148/255.0 alpha:1]];
        [bButton.layer setBorderWidth:0];
        [self topSegmentAction:_segment];

    }
    [_tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
