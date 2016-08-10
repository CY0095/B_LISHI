//
//  ShopViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopRequest.h"
#import "ShopTableViewCell.h"
#import "ShopDetailViewController.h"
#import "ShopModel.h"
#import <CoreLocation/CoreLocation.h>

@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

//存放商店的数组
@property (strong, nonatomic) NSMutableArray *shopDetailArr;
//商店的TableView
@property (strong, nonatomic) UITableView *shopTableView;
//位置管理器
@property(nonatomic, strong)CLLocationManager *locMagr;
//设置经纬度
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
//设置请求商店的递增数字
@property (assign, nonatomic) NSInteger number;

@end

@implementation ShopViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [GiFHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.number = 0;
    
    self.title = @"店铺详情";
    
    //初始化数组
    self.shopDetailArr = [NSMutableArray array];
    
    //初始化TableView
    self.shopTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, WindownWidth, WindowHeight - 64))];
    //设置代理 
    self.shopTableView.delegate = self;
    self.shopTableView.dataSource = self;
    //注册cell
    [self.shopTableView registerNib:[UINib nibWithNibName:@"ShopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:shopViewCell_Identify];
    //添加视图
    [self.view addSubview:self.shopTableView];
    
    [self LocationAdd];
//    [self DataRequest];
    self.view.backgroundColor = [UIColor cyanColor];
    
    //加载缓冲效果
    [GiFHUD setGifWithImageName:@"loading.gif"];
    [GiFHUD show];
    
    //创建下拉刷新
//    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        [self performSelector:@selector(headRefresh)withObject:nil afterDelay:2.0f];
//        
//    }];
//    
//    //设置自定义文字，因为默认是英文的
//    [header setTitle:@"下拉刷新"forState:MJRefreshStateIdle];
//    
//    [header setTitle:@"松开加载更多"forState:MJRefreshStatePulling];
//    
//    [header setTitle:@"正在刷新中"forState:MJRefreshStateRefreshing];
//    
//    
//    self.shopTableView.mj_header= header;
    
    //创建上拉刷新
    MJRefreshBackNormalFooter * foot =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self performSelector:@selector(footRefresh)withObject:nil afterDelay:2.0f];
        
    }];
    self.shopTableView.mj_footer= foot;
    
    [foot setTitle:@"上拉刷新"forState:MJRefreshStateIdle];
    
    [foot setTitle:@"松开加载更多"forState:MJRefreshStatePulling];
    
    [foot setTitle:@"正在刷新中"forState:MJRefreshStateRefreshing];
    
}

//#pragma mark --- 下拉刷新 ---
//- (void)headRefresh {
//    NSLog(@"下拉,加载数据");
//    self.number ++;
//    [self.shopTableView.mj_header endRefreshing];
//}

#pragma mark --- 上拉刷新 ---
- (void)footRefresh {
    NSLog(@"上拉，加载数据");
    self.number ++;
//    [self DataRequest];
    [self.shopTableView.mj_footer endRefreshing];
}

#pragma mark --- 添加定位功能 ---
- (void)LocationAdd
{
    //1.创建位置管理器（定位用户的位置），创建完毕之后，是不会开启定位功能的，因为特别耗电，如果想要开启定位，则需要调用方法
    self.locMagr = [[CLLocationManager alloc]init];
    //2.设置代理
    self.locMagr.delegate = self;
    
    //3.desiredAccuracy:设置定位的精度
    self.locMagr.desiredAccuracy = kCLLocationAccuracyBest;
    //4.定位的频率，每隔多少米进行定位
    CLLocationDistance distance = 10;//十米定位一次
    self.locMagr.distanceFilter = distance;
    
    //4.授权设置
    [self.locMagr requestWhenInUseAuthorization];//需要的时候进行授权
    //5.开启定位
    [self.locMagr startUpdatingLocation];
}

#pragma mark --- 定位用户的经纬度,用于请求数据 ---
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //取出第一个位置
    CLLocation *location = [locations lastObject];
//    CLLocationCoordinate2D coordinate = location.coordinate;//位置坐标
    
    self.longitude = location.coordinate.longitude;
    self.latitude = location.coordinate.latitude;
    
    
    NSLog(@"longtitude == %f, latitude == %f",self.longitude,self.latitude);
    
    //如果不需要实时去定位，需要关闭行为服务
    [self.locMagr stopUpdatingLocation];
    [self DataRequest];
    
}

#pragma mark --- 请求数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    ShopRequest *request = [[ShopRequest alloc] init];
    
    NSLog(@"请求数据的经纬度 ： longtitude == %f， latitude == %f",weakself.longitude,weakself.latitude);
     [request shopRequestWithNumber:[NSString stringWithFormat:@"%ld",(long)weakself.number] Brand_id:self.model.brand_id Latitude:[NSString stringWithFormat:@"%f",weakself.latitude] Longitude:[NSString stringWithFormat:@"%f",weakself.longitude] sucess:^(NSDictionary *dic) {
        
        NSArray *event = [[dic objectForKey:@"data"] objectForKey:@"shoplist"];
        
        for (NSDictionary *tempDic in event) {
            
            ShopModel *model = [[ShopModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.shopDetailArr addObject:model];
            
            //取消缓冲效果
            [GiFHUD dismiss];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.shopTableView reloadData];
        });
        
//        NSLog(@"=== %@",weakself.shopDetailArr);
    } failure:^(NSError *error) {
        
        NSLog(@"fialure == %@",error);
    }];
}

#pragma mark --- 设置cell的行数 ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopDetailArr.count;
}

#pragma mark --- 设置cell ---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopViewCell_Identify];
    //取消点击cell的变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShopModel *model = self.shopDetailArr[indexPath.row];
    cell.model = model;
    //显示距离
    CGFloat dis = model.distance / 1000;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.1fkm",dis];
    //显示星级
    if (model.star < 5) {
        cell.img5.image = [UIImage imageNamed:@"star1"];
    }else if (model.star < 4)
    {
        cell.img5.image = [UIImage imageNamed:@"star1"];
        cell.img4.image = [UIImage imageNamed:@"star1"];
    }else if (model.star < 3)
    {
        cell.img5.image = [UIImage imageNamed:@"star1"];
        cell.img4.image = [UIImage imageNamed:@"star1"];
        cell.img3.image = [UIImage imageNamed:@"star1"];
    }
    
    return cell;
}

#pragma mark --- 返回cell的高度 ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
}

#pragma mark --- 点击cell跳转界面 ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDetailViewController *shopVC = [[ShopDetailViewController alloc] init];
    
    ShopModel *model = self.shopDetailArr[indexPath.row];
    shopVC.model = model;
    
    [self.navigationController pushViewController:shopVC animated:YES];
    
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
