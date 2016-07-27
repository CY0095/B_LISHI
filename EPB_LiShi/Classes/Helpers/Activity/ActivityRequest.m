//
//  ActivityRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ActivityRequest.h"

@implementation ActivityRequest


-(void)ActivityRequestParameter:(NSDictionary *)paramerter success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    NSString *Longitude = @"116.337219";
    NSString *Latitude = @"40.029247";
    [request requestWithUrl:ActivityRequest_Url(Latitude,Longitude) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}




-(void)ActivityRequestWithLongitude:(NSString *)longitude latitude:(NSString *)latitude parameter:(NSDictionary *)paramerter success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    [request requestWithUrl:ActivityRequest_Url(latitude, longitude) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
    
}


@end
