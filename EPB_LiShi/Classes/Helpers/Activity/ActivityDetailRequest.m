//
//  ActivityDetailRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ActivityDetailRequest.h"
#import "ActivityViewController.h"

@interface ActivityDetailRequest ()

@property(strong,nonatomic) ActivityViewController *activityVC;

@end

@implementation ActivityDetailRequest



-(void)ActivityDetailRequestParameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    
    
    [request sendDataWithUrl:ActivityDetailRequest_Url(@"3615", @"451321") paramters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


-(void)ActivityDetailRequestTwoParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [NetWorkRequest new];
    
    [request requestWithUrl:ActivityDetailRequest_Url(@"3615", @"451321") parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
    
}


-(void)ActivityDetailRequestWithUrl:(NSString *)url Parameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    
    NetWorkRequest *request = [NetWorkRequest new];
    
    [request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
    
    
}




@end
