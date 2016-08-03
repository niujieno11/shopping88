//
//  NetWorkRequest.h
//  学聚
//
//  Created by Zhangwenybx on 15-1-14.
//  Copyright (c) 2015年 天问科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

//登录
extern NSString *const kLogin;

//找回密码
extern NSString *const kFindPW;

//云店主首页显示信息
extern NSString *const kMyInfo;

//店铺浏览记录
extern NSString *const kVisitors;

extern NSString *const kGoodsDetail;

//浏览最多，统计出各个商品及被浏览数
extern NSString *const kGoodsViews;

//商品被浏览排名
extern NSString *const kMyRank;

//店铺浏览记录
extern NSString *const kVisitors;

//查看分时间段的访客和订单数
extern NSString *const kVisitAndOrders;

//发展客户
extern NSString *const kMy_member;

//我的商品
extern NSString *const kMyGoods;

//云店主对商品状态操作
extern NSString *const kGoodsOperate;

//商品搜索
extern NSString *const kSearch;

//商品分类列表
extern NSString *const kGoodsClassify;

//商品分类查看-新品
extern NSString *const kXinpin;

//商品分类查看-热销
extern NSString *const kRexiao;

//商品分类查看-利润
extern NSString *const kLirun;

//订单管理- 我的订单
/*unpay:待付款；unship：带发货；unreceive：待收货；unrate：待评价；finish：已完成；return：退款或取消；all：全部*/
extern NSString *const kMyOrder;

//订单管理-待付款
extern NSString *const kWaitPay;

//订单管理-（待发货、待收货）type：类型（dfh:待发货，dsh：待收货）
extern NSString *const kWaitSendAndReceive;

//订单管理- 退款
extern NSString *const kRefundMoney;

//订单管理- 已完成
extern NSString *const kFinishOrder;

//订单管理- 无效订单
extern NSString *const kCancelOrder;

//订单管理- 云店主修改订单价格
extern NSString *const kChangePrice;

//订单管理- 云店主订单详情
extern NSString *const kOrderdetail;

//订单管理- 查物流
extern NSString *const kCheckLogistics;

//订单管理- 修改订单中单个商品价格
extern NSString *const kchangeGoodsPrice;


//客户管理
extern NSString *const kMember;

//分销管理
extern NSString *const kFenxiaor;

//财务管理
extern NSString *const kFinancial;

//模板列表
extern NSString *const kTemplateList;

//模板更新
extern NSString *const kTemplateUpdatet;

//上传图片
extern NSString *const kUploadPic;

//保存上传更新
extern NSString *const kSaveBannerLogoUpdate;

//宣传二维码、发展分销二维码 type:类型（erweimafx:分销二维码，erweimadp：店铺二维码）
extern NSString *const kGetQRCode;

//添加银行卡
extern NSString *const kAddBankCard;

extern NSString *const kFenxiaoOrders;


//提现记录
extern NSString *const kCashRecord;




extern NSString *const kEnvironmentStr1;


// 图片环境
extern NSString *const kEnvironmentImage;
// 图片环境
extern NSString *const kEnvironmentImage2;


//请求方式
extern NSString *const kConnectGetType;
extern NSString *const kConnectPostType;


typedef void (^SuccessBlcok)(id dic);
typedef void (^FailureBlcok)();

@interface NetWorkRequest : NSObject

+(void)netWorkRequestWithEnvironmentStr:(NSString *)environmentStr BaseURLStr:(NSString *)baseURLStr Parameters:(NSDictionary *)parameters style:(NSString *)style success:(SuccessBlcok)success failure:(FailureBlcok)failure;

@end
