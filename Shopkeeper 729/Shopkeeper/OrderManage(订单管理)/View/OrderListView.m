//
//  OrderListView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "OrderListView.h"
#import "OrderListCell.h"
#import "OrderListCellOnlySNHeaderView.h"
#import "OrderListCellHeaderView.h"


@implementation OrderListView

- (instancetype)initWithFrame:(CGRect)frame ViewType:(ViewType)viewType;
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDota) name:@"OrderListView" object:nil];
        
        [self createSiftView];
        
        _tableArr = [NSMutableArray array];
        
        _currentViewType = viewType;
        
        [self createTable];
        
        [self netWork];
        
    }
    return self;
}

-(ChangePriceView *)createSiftView
{
    
    if (!_changePriceView) {
        _changePriceView = [[ChangePriceView alloc]initWithFrame:CGRectMake(0, 64.5, Main_Screen_Width, Main_Screen_Height)];
//        _changePriceView.deletate = self;
        [_changePriceView setHidden:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:_changePriceView];
    }
    return _changePriceView;
}


-(void)reloadDota
{
    [self netWork];
}

-(void)netWork
{
    NSString * stateStr;
    switch (_currentViewType) {
        case AllStatesViewType:
            stateStr = @"all";
            break;
        case WaitPayViewType:
            stateStr = @"unpay";
            break;
        case WaitSendViewType:
            stateStr = @"unship";
            break;
        case WaitReceivedViewType:
            stateStr = @"unreceive";
            break;
        case WaitEvaluateViewType:
            stateStr = @"unrate";
            break;
        case FinishViewType:
            stateStr = @"finish";
            break;
        case RefundMoneyViewType:
            stateStr = @"return";
            break;
        case FailureViewType:
            stateStr = @"cancel";
            break;
            
        default:
            break;
    }
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    if (stateStr) {
        [dic setObject:stateStr forKey:@"statu"];
    }

    
    [LBProgressHUD showHUDto:self animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kMyOrder Parameters:dic style:kConnectPostType success:^(id dic) {
        
         NSLog(@"%@, kMyOrder == %@ ", stateStr, dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                [_tableArr removeAllObjects];
                
                for (NSDictionary * dict in dic[@"data"]) {
                    OrderListModel * model = [[OrderListModel alloc]init];
                    model = [OrderListModel objectWithKeyValues:dict];
                    if ([dict[@"goods_info"]isKindOfClass:[NSArray class]]) {
                        model.goods_info  = [GoodsModel objectArrayWithKeyValuesArray:dict[@"goods_info"]];
                        
                    }
                    if ([dict[@"op_logs"]isKindOfClass:[NSArray class]]) {
                        model.op_logs  = [GoodsModel objectArrayWithKeyValuesArray:dict[@"op_logs"]];
                    }
                    [_tableArr addObject:model];
                }
                [_tableView reloadData];
                
            }
        }
        
        if (_tableArr.count == 0) {
            _tableView.hidden = YES;
        }else {
            _tableView.hidden = NO;
        }
        [_tableView reloadData];
        
        
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
    }];
    
    
    
}

-(void)createTable
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, KSelf_Height) style:UITableViewStyleGrouped];
    [_tableView registerNib:[UINib nibWithNibName:@"OrderListCell" bundle:nil] forCellReuseIdentifier:@"OrderListCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_tableArr.count > 0) {
        return _tableArr.count;
    }else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tableArr.count > 0) {
        OrderListModel * listModel = _tableArr[section];
        return listModel.goods_info.count;
    }else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"OrderListCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListCell" owner:self options:nil] lastObject];
    }
    
    
    if (_tableArr.count > 0) {
        OrderListModel * listModel = _tableArr[indexPath.section];
        GoodsModel * goodsModel = listModel.goods_info[indexPath.row];
        [cell setModel:goodsModel];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_tableArr.count == 0) {
        return nil;
    }
    OrderListModel * listModel;
    OrderListModel * listModel2 ;
    
    //本行
    listModel = _tableArr[section];

    //下一行
    if (section == _tableArr.count-1) {
         return nil;
    }else {
        listModel2 = _tableArr[section+1];
    }
    
    
    if ([listModel.add_timex isEqualToString:listModel2.add_timex]) {
        return nil;
    }else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake( 0 , 0, Main_Screen_Width, 10)];
        [view setBackgroundColor:RGBCOLOR(234, 234, 241)];
        return view;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_tableArr.count == 0) {
        return 0;
    }
    
    OrderListModel * listModel;
    OrderListModel * listModel2 ;
    if (section>0) {
        listModel = _tableArr[section-1];
    }
    listModel2 = _tableArr[section];
    
    
    if ([listModel2.add_timex isEqualToString:listModel.add_timex]) {
        return 50;
    }else {
        return 90;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_tableArr.count == 0) {
        return nil;
    }
    
    OrderListModel * listModel;
    OrderListModel * listModel2 ;
    if (section>0) {
        listModel = _tableArr[section-1];
    }
    listModel2 = _tableArr[section];


    if ([listModel2.add_timex isEqualToString:listModel.add_timex]) {
        static NSString * headerIndetifer = @"OrderListCellOnlySNHeaderView";
        OrderListCellOnlySNHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIndetifer];
        if (!header) {
            header = [[OrderListCellOnlySNHeaderView alloc]initWithReuseIdentifier:headerIndetifer];
        }
        
        
        OrderListModel * listModel = _tableArr[section];
        
        [header setModel:listModel];
        
        if (_currentViewType == AllStatesViewType) {
            header.stateLable.text = listModel.statu;
            [header.stateLable setHidden:NO];
            [header.stateLineLable setHidden:NO];
            if ([listModel.statu isEqualToString:@"待付款"]) {
                [header.stateLable setTextColor:RGBCOLOR(18, 189, 250)];
                
            }else if ([listModel.statu isEqualToString:@"待发货"]) {
                [header.stateLable setTextColor:RGBCOLOR(245, 168, 40)];
                
            }else if ([listModel.statu isEqualToString:@"待收货"]) {
                [header.stateLable setTextColor:RGBCOLOR(255, 33, 85)];
                
            }else {
                [header.stateLable setTextColor:RGBCOLOR(97, 197, 94)];
            }
        }
        
        
        return header;
    }else {
        static NSString * headerIndetifer = @"OrderListCellHeaderView";
        OrderListCellHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIndetifer];
        if (!header) {
            header = [[OrderListCellHeaderView alloc]initWithReuseIdentifier:headerIndetifer];
        }
        
        
        OrderListModel * listModel = _tableArr[section];
        
        [header setModel:listModel];
        
        if (_currentViewType == AllStatesViewType) {
            [header.stateLable setHidden:NO];
            [header.stateLineLable setHidden:NO];
            header.stateLable.text = listModel.statu;
            if ([listModel.statu isEqualToString:@"待付款"]) {
                [header.stateLable setTextColor:RGBCOLOR(18, 189, 250)];

            }else if ([listModel.statu isEqualToString:@"待发货"]) {
                [header.stateLable setTextColor:RGBCOLOR(245, 168, 40)];
                
            }else if ([listModel.statu isEqualToString:@"待收货"]) {
                [header.stateLable setTextColor:RGBCOLOR(255, 33, 85)];
                
            }else {
                [header.stateLable setTextColor:RGBCOLOR(97, 197, 94)];
            }
        }
        
                 
        
        return header;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_tableArr.count > 0) {
        OrderListModel * listModel = _tableArr[indexPath.section];
        if ([self.delegate respondsToSelector:@selector(orderListViewPushWith:OrderListModel:)]) {
            [self.delegate orderListViewPushWith:_currentViewType OrderListModel:listModel];
        }
    }
    
}


#pragma mark 提示黑窗

- (void)createAlertView:(NSString *)text
{
    
    
    UILabel *successAlert = [[UILabel alloc]initWithFrame:
                    CGRectMake(self.frame.size.width/2 - 130, self.frame.size.height/2-100, 260, 85)];
    successAlert.textColor = [UIColor whiteColor];
    successAlert.textAlignment = 1;
    successAlert.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.7];
    [successAlert.layer setCornerRadius:3];
    [successAlert.layer setMasksToBounds:YES];
    [successAlert setText:text];
    [successAlert setFont:[UIFont systemFontOfSize:20]];
    [self addSubview:successAlert];
    
    [UIView animateWithDuration:0.4 animations:^{
        successAlert.transform = CGAffineTransformMakeScale(0.6, 0.6);
    } completion:^(BOOL finished) {
        //慢慢变透明，然后消失
        [UIView animateWithDuration:3
                         animations:^{
                             successAlert.alpha = 0;
                         }];
        [successAlert performSelector:@selector(removeFromSuperview)withObject:nil afterDelay:3];
        
    }];
}



@end
