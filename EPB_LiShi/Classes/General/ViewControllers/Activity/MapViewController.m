//
//  MapViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"
@interface MapViewController ()<MKMapViewDelegate>

@property(strong,nonatomic) NSString *longitude;

@property(strong,nonatomic) NSString *latitude;

@property(strong,nonatomic) MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView = [MKMapView new];
    self.mapView.frame = self.view.bounds;
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    
    
    
    
    
    self.longitude = self.model.gaodlongitude;
    self.latitude = self.model.gaodelatitude;
//    NSLog(@"++++++++++%@",self.longitude);
//    NSLog(@"+++++++++%@",self.latitude);
    
    self.longitude = self.model1.gaode_longitude;
    self.latitude = self.model1.gaode_latitude;
    
    [self addAnnotation];
    
    
    
}




-(void)addAnnotation{
    
    double longitude = [self.longitude doubleValue];
    double latitude = [self.latitude doubleValue];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude, longitude);
    
    Annotation *annotation = [[Annotation alloc] init];
    
    annotation.title = self.model.setaddress;
    annotation.coordinate = location;
    [self.mapView addAnnotation:annotation];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(annotation.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    
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
