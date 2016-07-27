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

@property(assign,nonatomic) double latitude;

@property(assign,nonatomic) double longitude;
// 地理编码和反编码需要使用的属性
@property(strong,nonatomic) CLGeocoder *geocoder;

@end

@implementation ActivityViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    // 设置代理
    self.mapView.delegate = self;
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    // 1、创建位置管理器(定位用户设置)，创建完毕之后，是不会开启定位功能，因为特别耗电，如果想要开启定位，需要调用方法
    self.locMgr = [[CLLocationManager alloc] init];
    // 2、设置代理
    self.locMgr.delegate = self;
    // 设置定位的精度
    self.locMgr.distanceFilter = 10;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyBest; // 最精确
    // 授权
    [self.locMgr requestAlwaysAuthorization];
    // 开启定位
    [self.locMgr startUpdatingLocation];
    
    // 初始化
    self.dataArray = [NSMutableArray array];
    self.imgArr = [NSMutableArray array];
    self.dataArr = [NSMutableArray array];
    
    
    [self.ActivityTableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActivityTableViewCell_Identify];
    
    [self requestActivityData];
    
    
    [self mapTitle];
    
    
    
}

-(void)mapTitle{
    
    }



-(void)requestActivityData{
    __weak typeof(self) weakSelf = self;
    ActivityRequest *request = [[ActivityRequest alloc] init];
    
    [request ActivityRequestWithLongitude:[NSString stringWithFormat:@"%f",self.longitude] latitude:[NSString stringWithFormat:@"%f",self.latitude] parameter:nil success:^(NSDictionary *dic) {
        
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
    
    // 获取定位的位置信息
    CLLocation *location = locations.lastObject;
    
    // 位置中的经纬度
    // 纬度
    self.latitude = location.coordinate.latitude;
    // 经度
    self.longitude = location.coordinate.longitude;
    // 海拔高度
    double altitude = location.altitude;
    // 航向(正北方向为0，取值范围0~359.9°)
    double course = location.course;
    // 速度
    double speed = location.speed;
    // 当地标准时间
    NSDate *time = location.timestamp;
    
    
    NSLog(@"%f",self.latitude);
    
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    NSLog(@"-----------------%f",self.latitude);
    NSLog(@"-----------------%f",self.longitude);
    [self.geocoder reverseGeocodeLocation:location1 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placeMark = placemarks.firstObject;
        NSString *city = [placeMark.addressDictionary objectForKey:@"State"];
        self.title = city;
    }];

    
    
    // 通常为了节省电量和资源损耗，在获取到位置以后选择停止定位服务
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
    
    ActivityModel *model = [[ActivityModel alloc] init];
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
