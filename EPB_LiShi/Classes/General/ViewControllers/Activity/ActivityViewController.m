//
//  ActivityViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ActivityViewController.h"
#import <MapKit/MapKit.h>
#import "ActivityTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "ActivityRequest.h"
#import "CycleModel.h"
#import <SDCycleScrollView.h>
#import "ActivityModel.h"
#import "ActivityDetailViewController.h"



@interface ActivityViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
MKMapViewDelegate,
CLLocationManagerDelegate,
UIScrollViewDelegate,
SDCycleScrollViewDelegate
>

//@property (weak, nonatomic) IBOutlet UITableView *ActivityTableView;

@property (weak, nonatomic) IBOutlet UITableView *ActivityTableView;

// 将位置管理器写成属性
@property(strong,nonatomic) CLLocationManager *locMgr;

@property(assign,nonatomic) CLLocationCoordinate2D coordinate;
// 存放CycleModel的数据
@property(strong,nonatomic) NSMutableArray *dataArray;

@property(strong,nonatomic) CycleModel *model;

@property(strong,nonatomic) MKMapView *mapView;
// 存放轮播图片的数组
@property(strong,nonatomic) NSMutableArray *imgArr;
// 存放ActivityModel的数据
@property(strong,nonatomic) NSMutableArray *dataArr;

@property(strong,nonatomic) ActivityModel *activityModel;


@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    // 设置代理
    self.mapView.delegate = self;
    
    
    
    // 1、创建位置管理器(定位用户设置)，创建完毕之后，是不会开启定位功能，因为特别耗电，如果想要开启定位，需要调用方法
    self.locMgr = [[CLLocationManager alloc] init];
    // 2、设置代理
    self.locMgr.delegate = self;
    // 设置定位的精度
    self.locMgr.desiredAccuracy = kCLLocationAccuracyBest; // 最精确
    // 授权
    [self.locMgr requestWhenInUseAuthorization]; // 需要时候授权
    // 开启定位
    [self.locMgr startUpdatingLocation];
    
    // 初始化
    self.dataArray = [NSMutableArray array];
    self.imgArr = [NSMutableArray array];
    self.dataArr = [NSMutableArray array];
    
    
    [self.ActivityTableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActivityTableViewCell_Identify];
    
    [self requestActivityData];
    
    
}



-(void)requestActivityData{
    __weak typeof(self) weakSelf = self;
    ActivityRequest *request = [[ActivityRequest alloc] init];
    [request ActivityRequestParameter:nil success:^(NSDictionary *dic) {
        
        NSDictionary *tempEvents = [dic objectForKey:@"data"];
        
        NSArray *tempArr = [tempEvents objectForKey:@"adlist"];
        for (NSDictionary *tempDic in tempArr) {
            weakSelf.model = [[CycleModel alloc] init];
            [weakSelf.model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.dataArray addObject:weakSelf.model];
            NSURL *url = [NSURL URLWithString:weakSelf.model.images];
            [weakSelf.imgArr addObject:url];
        }
        
        NSArray *tempArray = [tempEvents objectForKey:@"activitylist"];
        for (NSDictionary *tempDict in tempArray) {
            
            weakSelf.activityModel = [[ActivityModel alloc] init];
            [weakSelf.activityModel setValuesForKeysWithDictionary:tempDict];
            [weakSelf.dataArr addObject:weakSelf.activityModel];
            
        }
        
        NSLog(@"%@",weakSelf.dataArr);
        NSLog(@"%@",weakSelf.dataArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.ActivityTableView reloadData];
            [self cycleImage];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"Activity error = %@",error);
    }];
    
    
}


-(void)cycleImage{
    
    SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WindownWidth, 245) imageURLStringsGroup:self.imgArr];
    cycle.delegate = self;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 245)];
    
    [view addSubview:cycle];
    self.ActivityTableView.tableHeaderView = view;
    
    NSLog(@"asdasd");
    
}






-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations firstObject]; // 取出第一个位置
    
    self.coordinate = location.coordinate; // 位置坐标
    
    NSLog(@"经度 %f，纬度 %f",self.coordinate.longitude,self.coordinate.latitude);
    
    // 如果不需要实时定位，需要关闭定位服务
    [self.locMgr stopUpdatingLocation];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%ld",self.dataArray.count);
    
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 251;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityTableViewCell_Identify];
    
    self.activityModel = self.dataArr[indexPath.row];
    cell.model = self.activityModel;
    
    
    
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityDetailViewController *activityVC = [ActivityDetailViewController new];
    
    ActivityModel *model = [ActivityModel new];
    model = self.dataArr[indexPath.row];
    
    activityVC.DetailIDString = model.ID;
    [self.navigationController pushViewController:activityVC animated:YES];
    
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