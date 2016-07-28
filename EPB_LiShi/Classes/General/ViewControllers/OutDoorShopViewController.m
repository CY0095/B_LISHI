//
//  OutDoorShopViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "OutDoorShopViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface OutDoorShopViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

//定位管理器
@property (strong, nonatomic)CLLocationManager *manager;

@end

@implementation OutDoorShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //定位
    self.manager = [[CLLocationManager alloc] init];
    //定位的距离
    self.manager.distanceFilter = 10;
    //定位的精度
    self.manager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    //设置代理
    self.manager.delegate = self;
    //请求定位
    if ([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        
        [self.manager requestAlwaysAuthorization];
    }
    //使用的时候才进行定位
    [self.manager requestWhenInUseAuthorization];
    
    //开始定位
    [self.manager startUpdatingLocation];
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
