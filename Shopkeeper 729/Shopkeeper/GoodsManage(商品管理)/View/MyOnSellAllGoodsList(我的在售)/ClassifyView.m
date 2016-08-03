//
//  ClassifyView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/11.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "ClassifyView.h"
#import "GroupCollectionCell.h"
#import "GroupSection.h"
#import "NSString+Extension.h"

@implementation ClassifyView

- (instancetype)initWithFrame:(CGRect)frame ifMy:(NSString *)IfMy
{
    self = [super initWithFrame:frame];
    if (self) {
        _ifMy = IfMy;
        _collectionArr = [[NSMutableArray alloc]init];
        _stateArray = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor whiteColor];

        [self createCollectionView];
        
        [self netWork];
        
    }
    return self;
}

-(void)netWork{
    
    [LBProgressHUD showHUDto:self animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsClassify Parameters:nil style:kConnectPostType success:^(id dic) {
        
//        NSLog(@"kGoodsClassify == %@",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in dic[@"data"]) {
                    GoodsClassifyModel * model = [[GoodsClassifyModel alloc]init];
                    [model toModelWithDict:dict];
                    [_collectionArr addObject:model];
                }
                
                for (int i = 0; i < _collectionArr.count; i++)
                {
                    //所有的分区都是闭合
                    [_stateArray addObject:@"0"];
                }
                
                [_collectionView reloadData];
                
            }else {
                
            }
        }
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
    }];

    
}
-(void)createCollectionView
{
    //创建CollectionView布局类的对象，UICollectionViewFlowLayout有水平和垂直两种布局方式，如果你需要做复杂的而已可以继承UICollectionViewFlowLayout创建你自己的布局类
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //指定布局方式为垂直
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = 10;//最小行间距(当垂直布局时是行间距，当水平布局时可以理解为列间距)
    flow.minimumInteritemSpacing = 10;//两个单元格之间的最小间距
    
    //创建CollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSelf_Width, KSelf_Height) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    
    //注册用xib定制的cell，各参数的含义同UITableViewCell的注册
    [_collectionView registerNib:[UINib nibWithNibName:@"GroupCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GroupCellID"];
    
    //注册用xib定制的分组脚
    //参数二：用来区分是分组头还是分组脚
    [_collectionView registerNib:[UINib nibWithNibName:@"GroupSection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupSectionID"];

}

//协议的方法,用于返回section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _collectionArr.count;
}

//协议中的方法，用于返回分区中的单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_stateArray[section] isEqualToString:@"1"]) {
        //如果是打开状态
        GoodsClassifyModel * model = _collectionArr[section];
        return model.childArr.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //UICollectionViewCell里的属性非常少，实际做项目的时候几乎必须以其为基类定制自己的Cell
    GroupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCellID" forIndexPath:indexPath];
    
    if (_collectionArr.count> 0) {
        GoodsClassifyModel * model = _collectionArr[indexPath.section];
        GoodsClassifyModel * childModel = model.childArr[indexPath.row];
        [cell.nameLable setText:childModel.goods_class_name];
    }
    
    return cell;
}

//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsClassifyModel * model = _collectionArr[indexPath.section];
    GoodsClassifyModel * childModel = model.childArr[indexPath.row];

    CGSize size =[childModel.goods_class_name sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, 20)];

    return CGSizeMake(size.width+50, 44);
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(10, 5, 0, 5);
}

//协议中的方法，用来返回分组头的大小。如果不实现这个方法，- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath将不会被调用
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    //宽度随便定，系统会自动取collectionView的宽度
    //高度为分组头的高度
    return CGSizeMake(0, 54);
}


//协议中的方法，用来返回CollectionView的分组头或者分组脚
//参数二：用来区分是分组头还是分组脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //重用分组头，因为前边注册过，所以重用一定会成功
    //参数一：用来区分是分组头还是分组脚
    //参数二：注册分组头时指定的ID
    GroupSection *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupSectionID" forIndexPath:indexPath];
    
    GoodsClassifyModel * model = _collectionArr[indexPath.section];
    header.sectionTitle.text = model.goods_class_name;
    [header.sectionBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    header.sectionBtn.tag = indexPath.section + 1;
    
    if ([_stateArray[indexPath.section] isEqualToString:@"0"]) {
        //        header.iconImage.backgroundColor = [UIColor redColor];
        header.iconImage.image = [UIImage imageNamed:@"btn_menu_normal"];
        header.imgHeight.constant = 12.0f;
        header.imgWidth.constant = 7.0f;
        
    }
    else if ([_stateArray[indexPath.section] isEqualToString:@"1"]){
        header.iconImage.image = [UIImage imageNamed:@"btn_menu"];
        header.imgHeight.constant = 7.0f;
        header.imgWidth.constant = 12.0f;
         
    }
    return header;
}

- (void)buttonClick:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([_stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1]];
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_collectionArr.count> 0) {
        GoodsClassifyModel * model = _collectionArr[indexPath.section];
        [self.delegate classifyViewPushToListWithClassID:model.goods_class_id ClassName:model.goods_class_name ifMy:_ifMy];

    }
}

@end
