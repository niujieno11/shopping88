//
//  GoodDetailsController.h
//  商品详情
//
//  Created by kevin on 16/6/16.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdView.h"
@interface GoodDetailsController : BaseController

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong) UILabel *addressLabel;//地址
@property (nonatomic, strong) UILabel *qian;//现价
@property (nonatomic, strong) UILabel *yuanjia;//原价
@property (nonatomic, strong) UILabel *number;//货号
@property (nonatomic, strong) UILabel *date;//时间
@property (nonatomic, strong) UILabel *inventory;//库存
@property (nonatomic, strong) UILabel *weigth;//重量
@property (nonatomic, strong) UILabel *Nweigth;//重量
@property (nonatomic, strong) UILabel *Nmanual;//手工
@property (nonatomic, strong) UILabel *Nwight;//长度
@property (nonatomic, strong) UILabel *Nhight;//厚度
@property (nonatomic, strong) UILabel *NMosaic;//镶嵌
@property (nonatomic, strong) UILabel *Ncertificate;//证书
@property (nonatomic, strong) UILabel *Ncustom;//定制
@property (nonatomic, strong) UILabel *Ninternational;//国际
@property (nonatomic, strong) UILabel *NwidthOfThe;//宽度
@property (nonatomic, strong)  UILabel *NUsingGender;//使用性别
@property (nonatomic, strong)  UILabel *style;
@property (nonatomic, strong) UILabel *Nstyle;//类别时尚
@property (nonatomic, strong) UILabel *Nprice;//价格区间
@property (nonatomic, strong) AdView *adImageScrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong)  UIScrollView *scrollView;
@end
