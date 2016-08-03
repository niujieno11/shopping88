//
//  GoodDetailsController.m
//  商品详情
//
//  Created by kevin on 16/6/16.
//  Copyright © 2016年 张天兴. All rights reserved.
//

#import "GoodDetailsController.h"
#import "GoodsManageController.h"
//#import "GoodDetails.h"
@interface GoodDetailsController ()<UIScrollViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSMutableArray *arrImage;
@end

#define navH 64

@implementation GoodDetailsController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"商品详情";

    [self.view setBackgroundColor:[UIColor whiteColor]];
//    self.ID = @"99";
//    self.dic = [NSDictionary dictionary];
////    _arrImage = [NSMutableArray array];
//    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor redColor];
//
////    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GoodDetailsView" owner:self options:nil];
////    //得到第一个UIView
////    UIView *view = [nib objectAtIndex:0];
////    //获取屏幕的Frame
////    CGRect tmpFrame = [UIScreen mainScreen].bounds;
////    //设置自定义视图的中心点为屏幕的中心
////    [view setCenter:CGPointMake(tmpFrame.size.width/2, tmpFrame.size.height/2)];
////    view.backgroundColor = [UIColor redColor];
////    [self.view addSubview:view];
////    //1.创建对象
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-navH)];
//    //2.配置属性
//    //    scrollView.backgroundColor = [UIColor redColor];
//    //2.1 设置内容区域的大小
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/2 + ([UIScreen mainScreen].bounds.size.height + 200)/2);
//    //2.2 修改内容区域的偏移量
//    //x变大，往左偏移，y变大往上偏移 1
//        scrollView.contentOffset =  CGPointMake(140, 400);
//    //2.3 是否显示滚动指示条
    _scrollView.showsHorizontalScrollIndicator = NO;//默认为YES
    _scrollView.showsVerticalScrollIndicator = NO;//默认为YES
//    //2.4 修改滚动指示条的样式
    //    scrollView.indicatorStyle =  UIScrollViewIndicatorStyleWhite;
//    //2.5 设置scrollView 能否滚动
    _scrollView.scrollEnabled = YES;//默认为YES
//    //2.6 设置方向锁，设置滑动时只能从一个方向滚动
//    _scrollView.directionalLockEnabled = YES;//默认为NO
//    //2.7 设置是否整屏滚动
//    _scrollView.pagingEnabled = YES;//默认为NO
//    //2.8 设置当滑动到屏幕边缘的时候是否出现反弹效果
//    _scrollView.bounces = YES;//默认为YES
//    //2.9 设置当内容区域等于或小于可视区域时，依然具有边界反弹效果
//    _scrollView.alwaysBounceHorizontal = YES;//默认为NO
//    _scrollView.alwaysBounceVertical = YES;//默认为NO
//    //2.10 设置点击状态栏，scrollView 是否回到顶部，此时y轴的偏移量是0
//    _scrollView.scrollsToTop = YES;//默认为YES
//
    //2.11 scrollView 的代理属性
//    //self指试图控制器对象
    _scrollView.delegate = self;
//
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+50)];
    [_scrollView addSubview:_topView];
    [self.view addSubview:_scrollView];

    [self layout];
    [self requestData];
}

-(void)createNavbar
{
    
}

- (void)layout{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2)];
//    view.backgroundColor = [UIColor redColor];
    [self.topView addSubview:view];
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view.frame)+20, 220, 20)];
    _addressLabel.textColor = [UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1] ;

    _addressLabel.text = @"大里鹤庆 新华村梅花鹿纯银吊坠";
    _addressLabel.font = [UIFont fontWithName:@"ArialMT" size:11];
    [self.topView addSubview:_addressLabel];


    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, CGRectGetMaxY(view.frame)+20, 2, 60)];
    xian.backgroundColor = [UIColor grayColor];
    xian.textColor = [UIColor colorWithRed:230/255.0 green:232/255.0 blue:232/255.0 alpha:1] ;

    [self.topView addSubview:xian];
     _qian = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, CGRectGetMaxY(view.frame)+15, 55, 25)];
    _qian.font = [UIFont fontWithName:@"ArialMT" size:11];
    _qian.text = @"45";
    _qian.textColor = [UIColor colorWithRed:208/255.0 green:79/255.0 blue:163/255.0 alpha:1] ;
    _qian.font = [UIFont systemFontOfSize:11 weight:2];
    [self.topView addSubview:_qian];
    _yuanjia = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, CGRectGetMaxY(_qian.frame)+10, 50, 25)];
    _yuanjia.textColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:1] ;

    _yuanjia.font = [UIFont fontWithName:@"ArialMT" size:11];
    _yuanjia.text = @"60";

    UILabel *axian = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(xian.frame)+10, [UIScreen mainScreen].bounds.size.width, 0.5)];
    axian.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    axian.textColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1] ;

    [self.topView addSubview:axian];
     _number= [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(axian.frame) +20, 120, 20)];
    _number.text = @"123456789012";
    _Nwight.tintColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];

    _number.font = [UIFont fontWithName:@"ArialMT" size:13];

    [self.topView addSubview:_number];
     _date= [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3+25, CGRectGetMaxY(axian.frame) +15, 95, 30)];
//    date.font = [UIFont fontWithName:@"ArialMT" size:17];

    _date.text = @"2016-06-17";
    _date.tintColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];

    [self.topView addSubview:_date];
    //inventory库存
     _inventory= [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, CGRectGetMaxY(axian.frame) +15, 80, 30)];
    _inventory.tintColor = [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1];

    _inventory.text = @"库存充足";
    _number.font = [UIFont fontWithName:@"ArialMT" size:15];

    [self.topView addSubview:_inventory];
    
    UILabel *bxian = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(axian.frame)+60, [UIScreen mainScreen].bounds.size.width, 1)];
    bxian.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    bxian.textColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1] ;
    [self.topView addSubview:bxian];
    
    
    
     _weigth= [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(bxian.frame) +5, 70, 20)];
    _weigth.text = @"重量（g）:";
    _weigth.font = [UIFont fontWithName:@"ArialMT" size:13];
    _weigth.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.topView addSubview:_weigth];
     _Nweigth= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +5, CGRectGetMaxY(bxian.frame) +5, 70, 20)];
    _Nweigth.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Nweigth.text = @"1.6";
    _Nweigth.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Nweigth];
    UILabel *manual = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_weigth.frame) +5, 40, 20)];
    manual.text = @"手工 :";
    manual.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    manual.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:manual];
     _Nmanual= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(manual.frame) +5, CGRectGetMaxY(_weigth.frame) +5, 70, 20)];
    _Nmanual.text = @"否";
    _Nmanual.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Nmanual.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Nmanual];
    UILabel *wight = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(manual.frame) +5, 85, 20)];
    wight.text = @"长度（mm) :";
    wight.font = [UIFont fontWithName:@"ArialMT" size:13];
    wight.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];

    [self.topView addSubview:wight];
     _Nwight= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +10, CGRectGetMaxY(manual.frame) +5, 70, 20)];
    _Nwight.text = @"150 ";
    _Nwight.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Nwight.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Nwight];
    UILabel *hight = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(wight.frame) +5, 85, 20)];
    hight.text = @"厚度（mm）:";
    hight.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    hight.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:hight];
    _Nhight = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +10, CGRectGetMaxY(wight.frame) +5, 70, 20)];
    _Nhight.text = @"3.7";
    _Nhight.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Nhight.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Nhight];
    UILabel *Mosaic = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(hight.frame) +5, 40, 20)];
    Mosaic.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    Mosaic.text = @"镶嵌:";
    Mosaic.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:Mosaic];
    _Nmanual = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(Mosaic.frame) +5, CGRectGetMaxY(hight.frame) +5, 40, 20)];
    _Nmanual.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Nmanual.text = @"镶嵌:";
    _Nmanual.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Nmanual];
    UILabel *certificate = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(Mosaic.frame) +5, 70, 20)];
    certificate.text = @"证书 :";
    certificate.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    certificate.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:certificate];
    _Ncertificate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(Mosaic.frame) +5, CGRectGetMaxY(Mosaic.frame) +5, 70, 20)];
    _Ncertificate.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Ncertificate.text = @"证书 :";
    _Ncertificate.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Ncertificate];
    UILabel *custom = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +100, CGRectGetMaxY(bxian.frame) +5, 40, 20)];
    custom.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    custom.text = @"定制 :";
    custom.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:custom];
    _Ncustom = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(custom.frame) +5, CGRectGetMaxY(bxian.frame) +5, 70, 20)];
    _Ncustom.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Ncustom.text = @"不支持";
    _Ncustom.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Ncustom];

    UILabel *international = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +100, CGRectGetMaxY(_weigth.frame) +5, 40, 20)];
    international.text = @"国际 :";
    international.font = [UIFont fontWithName:@"ArialMT" size:13];
    international.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.topView addSubview:international];
    _Ninternational = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(international.frame) +5, CGRectGetMaxY(_weigth.frame) +5, 70, 20)];
    _Ninternational.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Ninternational.text = @"s925纯银";
    _Ninternational.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Ninternational];

    UILabel *widthOfThe = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +100, CGRectGetMaxY(manual.frame) +5, 85, 20)];
    widthOfThe.text = @"宽度（mm） :";
    widthOfThe.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    widthOfThe.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:widthOfThe];
     _NwidthOfThe= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(widthOfThe.frame) +5, CGRectGetMaxY(manual.frame) +5, 70, 20)];
    _NwidthOfThe.text = @"13.7";
    _NwidthOfThe.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _NwidthOfThe.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_NwidthOfThe];
    UILabel *UsingGender = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +100, CGRectGetMaxY(wight.frame) +5, 70, 20)];
    UsingGender.text = @"使用性别 :";
    UsingGender.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    UsingGender.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:UsingGender];
    _NUsingGender= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(UsingGender.frame) +5, CGRectGetMaxY(wight.frame) +5, 70, 20)];
    _NUsingGender.text = @"女";
    _NUsingGender.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _NUsingGender.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_NUsingGender];
   _style = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +100, CGRectGetMaxY(hight.frame) +5, 40, 20)];
    _style.text = @"风格 :";
     _style.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];

    _style.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_style];
    _Nstyle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(custom.frame) +5, CGRectGetMaxY(hight.frame) +5, 70, 20)];
    _Nstyle.text = @"时尚流行";
    _Nstyle.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    _Nstyle.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Nstyle];
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weigth.frame) +100, CGRectGetMaxY(Mosaic.frame) +5, 70, 20)];
    price.text = @"价格区间 :";
    price.tintColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    price.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:price];
    _Nprice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(price.frame) +5, CGRectGetMaxY(Mosaic.frame) +5, 70, 20)];
    _Nprice.text = @"0-999";
    _Nprice.tintColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];

    _Nprice.font = [UIFont fontWithName:@"ArialMT" size:13];
    [self.topView addSubview:_Nprice];
    
    UILabel *cxian = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(price.frame) + 10, [UIScreen mainScreen].bounds.size.width, 1)];
    cxian.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1] ;
    [self.topView addSubview:cxian];
    UILabel *dxian = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cxian.frame) +10, [UIScreen mainScreen].bounds.size.width, 1)];
    dxian.textColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] ;
    dxian.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1] ;
    [self.topView addSubview:dxian];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 120, CGRectGetMaxY(dxian.frame)+10, 100, 40);
    [button setTitle:@"我要销售" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:209/255.0 green:45/255.0 blue:128/255.0 alpha:1];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button setTintColor:[UIColor colorWithRed:243/255.0 green:213/255.0 blue:231/255.0 alpha:1]];
    [_topView addSubview:button];
}
- (void)requestData{

    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.ID forKey:@"id"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsDetail Parameters:dic style:kConnectGetType success:^(id dic) {
        NSLog(@"dic == %@",dic);
        
        if ([dic[@"errcode"] integerValue] == 1) {
            _scrollView.hidden = YES;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"商品已下架" message:@"提示" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [self.view addSubview:alertView];
            [alertView show];
        }else{
            
        self.dic = dic[@"data"];
        
//        NSLog(@"kGoodsDetail == %@", self.dic);
//        NSLog(@"kGoodsDetail2 == %@", [self.dic[@"attrs"] class]);

        
        _arrImage = [NSMutableArray array];
        
        if (_dic[@"goods_img"]) {
            NSString *strImage1 = [NSString stringWithFormat:@"http://www.tianView.com/%@",_dic[@"goods_img"]];
            [_arrImage addObject:strImage1];
        }
        
        for (int i = 2; i < 9; i++) {
            
            NSString *str = [NSString stringWithFormat:@"goods_img%d",i];
            
            if (_dic[str]) {
                NSString *strImage = [NSString stringWithFormat:@"http://www.tianView.com/%@",_dic[str]];
                [_arrImage addObject:strImage];
            }
        }
        NSLog(@"_arrImage == %@",_arrImage);
        }
        AdView * adImageScrollView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), [UIScreen mainScreen].bounds.size.height/2)  \
        imageLinkURL:_arrImage\
        placeHoderImageName:@"placeHoder.jpg" \
        pageControlShowStyle:UIPageControlShowStyleCenter];
        [adImageScrollView setAdTitleArray:nil withShowStyle:AdTitleShowStyleRight];
        //    设置图片滚动时间,默认3s
        adImageScrollView.adMoveTime = 4.0;
        __weak typeof(self)wself = self;
        adImageScrollView.callBack = ^(NSInteger index,NSString * imageURL)
        {
            [wself networkImageShow:index ImageArr:_arrImage AdView:adImageScrollView];
        };
        [_topView addSubview:adImageScrollView];
        _addressLabel.text = self.dic[@"goods_name"];
        _qian.text = [NSString stringWithFormat:@"￥%@",self.dic[@"goods_price"]];
        _yuanjia.text = self.dic[@"old_price"];
        _yuanjia.text = [NSString stringWithFormat:@"￥%@",self.dic[@"old_price"]];
        
        //字符串中间穿横线
        NSString *oldPrice = _yuanjia.text;
        NSUInteger length = [oldPrice length];
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString: oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [_yuanjia setAttributedText:attri];
        [self.topView addSubview:_yuanjia];
        _number.text = self.dic[@"goods_sn"];

        //注册时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"YYYY-MM-dd"];
        //时间戳转时间
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970: [self.dic[@"add_time"] doubleValue]];
        //时间按格式转字符串
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        _date.text = confromTimespStr;
        
        NSDictionary *attrsDic = self.dic[@"attrs"];
        NSArray *attrsArr = attrsDic[@"重量(g)"];
        for (NSDictionary *diDic in attrsArr) {
            _Nweigth.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr1 = attrsDic[@"手工"];
        for (NSDictionary *diDic in attrsArr1) {
            _Nmanual.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr2 = attrsDic[@"内径(mm)"];
        for (NSDictionary *diDic in attrsArr2) {
            _Nwight.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr3 = attrsDic[@"厚度(mm)"];
        for (NSDictionary *diDic in attrsArr3) {
            _Nhight.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr4 = attrsDic[@"镶嵌"];
        for (NSDictionary *diDic in attrsArr4) {
            _NMosaic.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr5 = attrsDic[@"证书"];
        for (NSDictionary *diDic in attrsArr5) {
            _Ncertificate.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr6 = attrsDic[@"定制"];
        for (NSDictionary *diDic in attrsArr6) {
            _Ncustom.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr7 = attrsDic[@"国标"];
        for (NSDictionary *diDic in attrsArr7) {
            _Ninternational.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr8 = attrsDic[@"宽度(mm)"];
        for (NSDictionary *diDic in attrsArr8) {
            _NwidthOfThe.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr9 = attrsDic[@"适用性别"];
        for (NSDictionary *diDic in attrsArr9) {
            _NUsingGender.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr10 = attrsDic[@"风格"];
        for (NSDictionary *diDic in attrsArr10) {
            _Nstyle.text = diDic[@"attr_value"];
        }
        NSArray *attrsArr11 = attrsDic[@"价格区间"];
        for (NSDictionary *diDic in attrsArr11) {
            _Nprice.text = diDic[@"attr_value"];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    } failure:^(NSError *error) {
        
        //移除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       NSLog(@"error -- %@",error);
    }];
     
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 我要销售的点击事件
-(void)buttonAction:(UIButton *)button {
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    if (self.ID) {
        [dic setObject:self.ID forKey:@"goods_id"];
    }
    
    [dic setObject:@"sale" forKey:@"type"];
    
    [LCProgressHUD showLoading:@"上架中"];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsOperate Parameters:dic style:kConnectPostType success:^(id dic) {
        NSLog(@"kGoodsOperate == %@",dic);
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            [LCProgressHUD showSuccess:@"上架成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MyOnSellAllGoodsListView" object:nil];
            
        }else {
            [LCProgressHUD showFailure:@"上架失败"];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LCProgressHUD hide];
        
    }];

}

#pragma mark - 图片跳转代理
-(void)networkImageShow:(NSUInteger)index ImageArr:(NSMutableArray *)imageArr AdView:(AdView *)imageScrollView
{
    //    __weak typeof(self) weakSelf=self;
    
//    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
//        
//        
//        NSArray *networkImages= imageArr;
//        
//        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
//        
//        for (NSUInteger i = 0; i< (networkImages.count-1); i++) {
//            
//            PhotoModel *pbModel=[[PhotoModel alloc] init];
//            pbModel.mid = i + 1;
//            //            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            //            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
//            pbModel.image_HD_U = networkImages[i];
//            
//            //源frame
////            UIImageView *imageV =(UIImageView *) imageScrollView.subviews[i];
////            pbModel.sourceImageView = imageV;
////            
////            [modelsM addObject:pbModel];
//        }
//        
//        return modelsM;
//    }];
}


@end
