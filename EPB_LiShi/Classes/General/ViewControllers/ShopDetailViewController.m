//
//  ShopDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ShopDetailModel.h"
#import "ShopDetailRequest.h"
#import "ShopDetailTableViewCell.h"
#import "ShopPhoneTableViewCell.h"
#import "ShopProductTableViewCell.h"
#import "PicModel.h"
#import <SDCycleScrollView.h>
#import "MapViewController.h"

@interface ShopDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ShopDetailDelegate>

//存放店铺详情的数组
@property (strong, nonatomic) NSMutableArray *shopDetailArr;
@property (strong, nonatomic) UITableView *shopDetailTableView;
//存放电话号的数组
@property (strong, nonatomic) NSMutableArray *telArr;
//存放商店的产品
@property (strong, nonatomic) NSMutableArray *productArr;
//添加scrollview
@property (strong, nonatomic) UIScrollView *ScrollView;
//商店的展示图片数组
@property (strong, nonatomic) NSMutableArray *ShopDetailPicArr;

@end

@implementation ShopDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.rootVC.LSTabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.rootVC.LSTabBar.hidden = NO;
    
    [GiFHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数组
    self.shopDetailArr = [NSMutableArray array];
    self.telArr = [NSMutableArray array];
    self.productArr = [NSMutableArray array];
    self.ShopDetailPicArr = [NSMutableArray array];
    
    //初始化TableView
    self.shopDetailTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, WindownWidth, WindowHeight - 80))];
    //设置代理
    self.shopDetailTableView.delegate = self;
    self.shopDetailTableView.dataSource = self;
    
    //注册cell
    [self.shopDetailTableView registerNib:[UINib nibWithNibName:@"ShopDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:shopDetailViewCell_Identify];
    [self.shopDetailTableView registerNib:[UINib nibWithNibName:@"ShopPhoneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:shopTellViewCell_Identify];
    [self.shopDetailTableView registerNib:[UINib nibWithNibName:@"ShopProductTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:shopProductViewCell_Identify];
    
    [self DataRequest];
    //添加视图
    [self.view addSubview:self.shopDetailTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //加载缓冲效果
    [GiFHUD setGifWithImageName:@"loading.gif"];
    [GiFHUD show];
}

#pragma mark --- 请求数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    ShopDetailRequest *request = [[ShopDetailRequest alloc] init];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if (user_id.length == 0) {
        user_id = @"0";
    }
    
    [request shopRequestWithId:self.model.oid User_id:user_id sucess:^(NSDictionary *dic) {
        
        NSDictionary *dict = [[dic objectForKey:@"data"] objectForKey:@"info"];
        ShopDetailModel *model = [[ShopDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [weakself.shopDetailArr addObject:model];
        [weakself.telArr addObject:model.phone];
        [weakself.productArr addObject:model];
        
        NSArray *event = [[dic objectForKey:@"data"] objectForKey:@"pic"];
        for (NSDictionary *temDic in event) {
            
            PicModel *model = [[PicModel alloc] init];
            [model setValuesForKeysWithDictionary:temDic];
            NSURL *url = [NSURL URLWithString:model.th_pic];
            [weakself.ShopDetailPicArr addObject:url];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self cycleShow];
            [self.shopDetailTableView reloadData];
            
            //取消效果
            [GiFHUD dismiss];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"failure == %@",error);
    }];
    
}

#pragma mark --- 设置头部轮播图 ---
- (void)cycleShow
{
    //设置轮播图
    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:(CGRectMake(0, 0, WindownWidth, 245)) imageURLStringsGroup:self.ShopDetailPicArr];
    //轮播图所在的view
    UIView *cycleView = [[UIView alloc] initWithFrame:(CGRectMake(0, 64, WindownWidth, 245))];
    cycleView.backgroundColor = [UIColor whiteColor];
    self.shopDetailTableView.tableHeaderView = cycleView;
    [cycleView addSubview:cycle];
}

#pragma mark --- 设置cell的区数 ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark --- 设置cell的行数 ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       return self.shopDetailArr.count;
    }else if(section == 1)
    {
        return self.telArr.count;
    }else
    {
        return self.productArr.count;
    }
    
}

#pragma mark --- 设置cell ---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ShopDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopDetailViewCell_Identify];
        
        //取消点击cell的变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ShopDetailModel *model = self.shopDetailArr[indexPath.row];
        cell.model = model;
        
        cell.delegate = self;
        
        return cell;
    }else if(indexPath.section == 1)
    {
        ShopPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopTellViewCell_Identify];
        //取消点击cell的变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *str = self.telArr[indexPath.row];
        
        if (str.length == 0) {
            cell.telCell.text = @"等待商家上传...";
        }else
        {
            cell.telCell.text = str;
        }
        
        return cell;
    }else
    {
        ShopProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopProductViewCell_Identify];
        //取消点击cell的变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //取消cell的下划线
        self.shopDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        ShopDetailModel *model = self.productArr[indexPath.row];
        cell.model = model;
        
        return cell;
    }
    
}

#pragma mark --- 设置点击代理返回button的方法 ---
- (void)buttonClick:(ShopDetailTableViewCell *)cell
{
    MapViewController *mapVC = [[MapViewController alloc] init];
    ShopDetailModel *model = cell.model;
    mapVC.model1 = model;
    
    [self.navigationController pushViewController:mapVC animated:YES];
    
}

#pragma mark --- 返回cell的高度 ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 98;
    }else if (indexPath.section == 1)
    {
        return 43;
    }else
    {
        ShopDetailModel *str = self.productArr[indexPath.row];
        
        return [ShopProductTableViewCell cellHeight:str];
    }
}

#pragma mark --- 设置调用电话 ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDetailModel *model = self.shopDetailArr[indexPath.row];
    
    //用如下方式，可以使得用户结束通话后自动返回到应用
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.phone]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
