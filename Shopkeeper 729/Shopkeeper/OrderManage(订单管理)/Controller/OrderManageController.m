//
//  OrderManageController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/13.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "OrderManageController.h"

@interface OrderManageController ()

@end

#define navH 120

@implementation OrderManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createNavbar];
    
    //三个视图
    [self createThreeView];
}

-(void)createNavbar
{
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, navH)];
    [navView setBackgroundColor:KMainColor];
    [self.view addSubview:navView];
    
    //2.登录按钮
    UIButton * backbButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 24, 60, 40)];
    [backbButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbButton addTarget:self action:@selector(backbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [backbButton setBackgroundColor:[UIColor blueColor]];
    [backbButton setImageEdgeInsets:UIEdgeInsetsMake(7, 17, 7, 17)];
    [self.view addSubview:backbButton];
    
    
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-50, 35, 100, 20)];
    [titleLable setText:@"订单管理"];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont systemFontOfSize:15]];
    [titleLable setTextAlignment:1];
    [navView addSubview:titleLable];
    
    UISegmentedControl *topSegment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@" 所有订单 ",@" 已完成 ", @" 退款/取消 ", nil]];
    [topSegment setFrame:CGRectMake(Main_Screen_Width/2-120, 75, 233, 30)];
    [topSegment setTintColor:[UIColor whiteColor]];
    [topSegment setBackgroundColor:RGBCOLOR(194, 0, 87)];
    [topSegment.layer setCornerRadius:4];
    [topSegment.layer setBorderWidth:0.5];
    [topSegment.layer setBorderColor:[UIColor whiteColor].CGColor];
    [topSegment addTarget:self action:@selector(topSegmentAction:) forControlEvents:UIControlEventValueChanged];
    [topSegment setSelectedSegmentIndex:0];
    [navView addSubview:topSegment];
}

-(void)backbButtonAction
{
    [_waitPayView.changePriceView viewDisapper];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)topSegmentAction:(UISegmentedControl *)topSegment
{
    if (topSegment.selectedSegmentIndex == 0) {
        _transactionView.hidden = NO;
        _finishView.hidden = YES;
        _failureView.hidden = YES;
        
    }else  if (topSegment.selectedSegmentIndex == 1) {
        _transactionView.hidden = YES;
        _finishView.hidden = NO;
        _failureView.hidden = YES;
        
    }else {
        _transactionView.hidden = YES;
        _finishView.hidden = YES;
        _failureView.hidden = NO;
        
    }
}

-(void)createThreeView
{
    //1.所有订单
    _transactionView = [[UIView alloc]initWithFrame:CGRectMake(0, navH, Main_Screen_Width, Main_Screen_Height-navH)];
    [self.view addSubview:_transactionView];
    
    NSArray * nameArr = @[@"全部订单", @"待付款", @"待发货", @"待收货", @"待评价"];
    for (int i = 0; i < nameArr.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/nameArr.count*i, 0, Main_Screen_Width/nameArr.count, 38)];
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:KMainColor forState:UIControlStateSelected];
        [button setTitleColor:RGBCOLOR(100, 100, 100) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(transactionViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:RGBCOLOR(234, 234, 234)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_transactionView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _currentSelectButton = button;
            [button setBackgroundColor:[UIColor whiteColor]];
        }
    }
    //1.1所有订单-所有订单,待付款，待收货，待发货，待评价
    for (int i = 0; i < nameArr.count; i++) {
        
        ViewType type;
        if (i == 0) {
            type = AllStatesViewType ;
        }else if (i == 1) {
            type = WaitPayViewType;
        }else  if (i == 2) {
            type = WaitSendViewType;
        }else  if (i == 3) {
            type = WaitReceivedViewType;
        }else {
            type = WaitEvaluateViewType;
        }
        OrderListView * order = [[OrderListView alloc]initWithFrame:CGRectMake(0, 38, Main_Screen_Width, Main_Screen_Height-navH-38) ViewType:type];
        order.delegate = self;
        if (i == 0) {
            order.hidden = NO;
        }else {
            order.hidden = YES;
        }
        [order setTag:(100+i)];
        [_transactionView addSubview:order];
        
        if (i == 0) {
            _allView = order;
        }else if (i == 1) {
            _waitPayView = order;
        }else  if (i == 2) {
            _waitSendView = order;
        }else  if (i == 3) {
            _waitReceiveView = order;
        }else {
            _waitEvelution = order;
        }
    }
    
    
    //2.已完成视图
    _finishView = [[OrderListView alloc]initWithFrame:CGRectMake(0, navH, Main_Screen_Width, Main_Screen_Height-navH) ViewType:FinishViewType];
    [_finishView setHidden:YES];
    _finishView.delegate = self;
    [self.view addSubview:_finishView];
    
 
    
    //3.退款/取消
    _failureView = [[UIView alloc]initWithFrame:CGRectMake(0, navH, Main_Screen_Width, Main_Screen_Height-navH)];
    [_failureView setHidden:YES];
    [self.view addSubview:_failureView];
 
    
    NSArray * nameArr2 = @[@"退款订单", @"买家取消"];
    for (int i = 0; i < nameArr2.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/nameArr2.count*i, 0, Main_Screen_Width/nameArr2.count, 38)];
        [button setTitle:nameArr2[i] forState:UIControlStateNormal];
        [button setTitleColor:KMainColor forState:UIControlStateSelected];
        [button setTitleColor:RGBCOLOR(100, 100, 100) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(failureViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:RGBCOLOR(234, 234, 234)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_failureView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _currentSelectButton2 = button;
            [button setBackgroundColor:[UIColor whiteColor]];
        }
        
        ViewType type;
        if (i == 0) {
            type = RefundMoneyViewType ;
        }else if (i == 1) {
            type = FailureViewType;
        }
        
        OrderListView * failureView = [[OrderListView alloc]initWithFrame:CGRectMake(0, 38, Main_Screen_Width, Main_Screen_Height-navH-38) ViewType:type];
        failureView.delegate = self;
        [_failureView addSubview:failureView];
        
        if (i == 0) {
            _refundMoneyView = failureView ;
        }else if (i == 1) {
            _customerfailureView = failureView ;
            [_customerfailureView setHidden:YES];
        }
    }

}

#pragma mark - 代理协议
-(void)orderListViewPushWith:(ViewType)viewType OrderListModel:(OrderListModel *)orderListModel
{
    OrderDetailController * detail = [[OrderDetailController alloc]init];
    detail.currentViewType = viewType;
    detail.orderListModel = orderListModel;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)transactionViewAction:(UIButton *)bt
{
    _currentSelectButton.selected = NO;
    [_currentSelectButton setBackgroundColor:RGBCOLOR(234, 234, 234)];
    
    bt.selected = YES;
    [bt setBackgroundColor:[UIColor whiteColor]];
    
    _currentSelectButton = bt;

    if ([bt.titleLabel.text isEqualToString:@"全部订单"]) {
        
        [_allView setHidden:NO];
        [_waitPayView setHidden:YES];
        [_waitSendView setHidden:YES];
        [_waitReceiveView setHidden:YES];
        [_waitEvelution setHidden:YES];

    }else if ([bt.titleLabel.text isEqualToString:@"待付款"]){
        [_allView setHidden:YES];
        [_waitPayView setHidden:NO];
        [_waitSendView setHidden:YES];
        [_waitReceiveView setHidden:YES];
        [_waitEvelution setHidden:YES];

    }else  if ([bt.titleLabel.text isEqualToString:@"待发货"]){
        [_allView setHidden:YES];
        [_waitPayView setHidden:YES];
        [_waitSendView setHidden:NO];
        [_waitReceiveView setHidden:YES];
        [_waitEvelution setHidden:YES];

    }else if ([bt.titleLabel.text isEqualToString:@"待收货"]){
        [_allView setHidden:YES];
        [_waitPayView setHidden:YES];
        [_waitSendView setHidden:YES];
        [_waitReceiveView setHidden:NO];
        [_waitEvelution setHidden:YES];

    }else {
        [_allView setHidden:YES];
        [_waitPayView setHidden:YES];
        [_waitSendView setHidden:YES];
        [_waitReceiveView setHidden:YES];
        [_waitEvelution setHidden:NO];
    }
}

-(void)failureViewAction:(UIButton *)bt
{
    _currentSelectButton2.selected = NO;
    [_currentSelectButton2 setBackgroundColor:RGBCOLOR(234, 234, 234)];
    
    bt.selected = YES;
    [bt setBackgroundColor:[UIColor whiteColor]];
    
    _currentSelectButton2 = bt;

    
    if ([bt.titleLabel.text isEqualToString:@"退款订单"]) {
        [_refundMoneyView setHidden:NO];
        [_customerfailureView setHidden:YES];
        
        
    }else if ([bt.titleLabel.text isEqualToString:@"买家取消"]){
        [_refundMoneyView setHidden:YES];
        [_customerfailureView setHidden:NO];
    }
}

@end
