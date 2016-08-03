//
//  NetWorkRequest.m
//  学聚
//
//  Created by Zhangwenybx on 15-1-14.
//  Copyright (c) 2015年 天问科技有限公司. All rights reserved.
//

#import "NetWorkRequest.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

//登录
NSString *const kLogin  = @"ydz_login";

//找回密码
NSString *const kFindPW  = @"ydz_findpswd";

//云店主首页显示信息
NSString *const kMyInfo  = @"ydz_my";


NSString *const kGoodsDetail  = @"ydz_goods_item";


//云店主首页显示信息
//NSString *const kMyInfo  = @"ydz_views";

//店铺浏览记录
NSString *const kVisitors  = @"ydz_visitors";


//浏览最多，统计出各个商品及被浏览数
NSString *const kGoodsViews  = @"ydz_goods_views";

//商品被浏览排名
NSString *const kMyRank  = @"ydz_paiming";

//查看分时间段的访客和订单数
NSString *const kVisitAndOrders  = @"ydz_visitAndOrders_num";

//发展客户
NSString *const kMy_member  = @"ydz_my_member";


//云店主对商品状态操作
//type：操作类型（下架nosale、删除商品dele、上架sale）
NSString *const kGoodsOperate  = @"ydz_sale_type";

/*store_id：云店编号
 type：在售1、下架0、全部all
 pagesize：每页大小，不输入时默认为50*/
//我的商品
NSString *const kMyGoods  = @"ydz_my_goods";

//商品分类列表
NSString *const kGoodsClassify  = @"ydz_goods_class";

//商品搜索
NSString *const kSearch  = @"ydz_search_goods";


//商品分类查看-新品
NSString *const kXinpin  = @"ydz_my_goods_fenlei_xinpin";

//商品分类查看-热销
NSString *const kRexiao  = @"ydz_my_goods_fenlei_rexiao";

//商品分类查看-利润
NSString *const kLirun = @"ydz_my_goods_fenlei_lirun";

//订单管理-待付款
NSString *const kWaitPay = @"ydz_dfk";

//订单管理-（待发货、待收货）type：类型（dfh:待发货，dsh：待收货）
NSString *const kWaitSendAndReceive = @"ydz_jyz";

//订单管理- 我的订单
/*unpay:待付款；unship：带发货；unreceive：待收货；unrate：待评价；finish：已完成；return：退款或取消；all：全部*/
NSString *const kMyOrder = @"ydz_my_orders";


//订单管理- 退款
NSString *const kRefundMoney = @"ydz_order_return";

//订单管理- 已完成
NSString *const kFinishOrder = @"ydz_order_finish";

//订单管理- 无效订单
NSString *const kCancelOrder = @"ydz_order_cancel";


//订单管理- 云店主修改订单价格
NSString *const kChangePrice = @"ydz_revised_price";

//订单管理- 云店主订单详情
NSString *const kOrderdetail = @"ydz_order_detail";

//订单管理- 查物流
NSString *const kCheckLogistics = @"ydz_orders_shipping_query";

//订单管理- 修改订单中单个商品价格
NSString *const kchangeGoodsPrice = @"ydz_my_orders_changePrice_goods";

//客户管理
NSString *const kMember = @"ydz_member";

//分销管理
NSString *const kFenxiaor = @"ydz_fenxiao";

//财务管理
NSString *const kFinancial = @"ydz_store_account_logs";


//提现记录
NSString *const kCashRecord = @"ydz_my_jiesuan_logs";



//模板列表
NSString *const kTemplateList = @"ydz_tpl_list";

//模板更新
NSString *const kTemplateUpdatet = @"ydz_tpl_update";

//上传图片
NSString *const kUploadPic = @"upload_pic";

//保存上传更新
NSString *const kSaveBannerLogoUpdate = @"yzd_update_banner_logo";

//宣传二维码、发展分销二维码 type:类型（erweimafx:分销二维码，erweimadp：店铺二维码）
NSString *const kGetQRCode = @"ydz_get_erweima";

//添加银行卡
NSString *const kAddBankCard = @"ydz_add_bank_card";

NSString *const kFenxiaoOrders = @"ydz_fenxiao_orders";





 
//请求方式
NSString *const kConnectGetType = @"GET";
NSString *const kConnectPostType = @"POST";

// 环境
//NSString *const kEnvironmentStr1 = @"http://www.ejoydg.com/api-"; //环境
NSString *const kEnvironmentStr1 = @"http://www.tianview.com/api-"; //环境

// 图片环境
NSString *const kEnvironmentImage = @"http://www.tianview.com/"; //图片环境

// 图片环境
NSString *const kEnvironmentImage2 = @"http://www.tianview.com/"; //图片环境

@implementation NetWorkRequest


+(void)netWorkRequestWithEnvironmentStr:(NSString *)environmentStr BaseURLStr:(NSString *)baseURLStr Parameters:(NSDictionary *)parameters style:(NSString *)style success:(SuccessBlcok)success failure:(FailureBlcok)failure
{

    

    NSString *str = @"";
    
    for (NSString *key in [parameters allKeys]) {
        if ([str length] == 0) {
            str= [NSString stringWithFormat:@"%@=%@",key,[parameters objectForKey:key]];
        }else{
            str = [NSString stringWithFormat:@"%@&%@=%@",str,key,[parameters objectForKey:key]];
        }
    }

    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@", environmentStr,baseURLStr, @".html?", str];
    NSString *postURLStr = [NSString stringWithFormat:@"%@%@%@",environmentStr, baseURLStr, @".html"];
    
    NSLog(@"urlStr == %@",urlStr);
    NSLog(@"postURLStr == %@",postURLStr);

    if ([style isEqualToString:kConnectPostType]) {
     //  AFHTTPSessionManager * sessionManager;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];

        
        [manager POST:postURLStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
           
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           failure(error);
        }];
        
 
        
    }else if([style isEqualToString:kConnectGetType]){
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/css", @"text/plain", nil]];
        
//        NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseURLStr, str];
        
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
          //  NSLog(@"URL == %@",operation.response.URL);
            
            failure(error);

        }];
        
       
    }
    [AFAppDotNetAPIClient sharedClientWithfailure:^(NSString * err) {
        
        failure(err);
    }];
}

//-(void)startConnectModel:(NSDictionary *)dic url:(NSString *)urlStr style:(NSString *)style
//{
//    NSString *str = @"";
//    
//    
//    for (NSString *key in [dic allKeys]) {
//        if ([str length] == 0) {
//            str= [NSString stringWithFormat:@"%@=%@",key,[dic objectForKey:key]];
//        }else{
//            str = [NSString stringWithFormat:@"%@&%@=%@",str,key,[dic objectForKey:key]];
//        }
//    }
//    
//    if ([style isEqualToString:kConnectPostType]) {
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        
//        
//        [manager POST:urlStr parameters:dic success: ^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//            
//            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
//            NSLog(@"%@", dic);
//            
//            
//        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"%@", error);
//        }];
//    }else if([style isEqualToString:kConnectGetType]){
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,str]];
//        
//        /**************************************************************************/
//        NSLog(@"url == %@",[NSString stringWithFormat:@"%@%@",urlStr,str]);
//        /**************************************************************************/
//        
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//        
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//            //            NSString *html = operation.responseString;
//            //            NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
//            //            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"发生错误 ! %@",error);
//        }];
//        [operation start];
//    }
//    
//}

@end
