//
//  ExchangeRequest.m
//  tools
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "ExchangeRequest.h"

@implementation ExchangeRequest

-(void)ExchangeRequestWithParameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
//    [request requestWithUrl:ExchangeRequest_Url parameters:parameterDic successRespone:^(NSDictionary *dic) {
//        
//        success(dic);
//    } failureRespone:^(NSError *error) {
//        
//        failure(error);
//    }];
    
    [request requestWithUrl:ExchangeRequest_Url parameters:parameterDic successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
}

@end
