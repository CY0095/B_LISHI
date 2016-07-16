//
//  ToolsRequest.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "ToolsRequest.h"

@implementation ToolsRequest

-(void)ToolsRequestWithParameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{    
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
//    [request requestWithUrl:ToolsRequest_Url parameters:parameterDic successRespone:^(NSDictionary *dic) {
//        
//        success(dic);
//    } failureRespone:^(NSError *error) {
//        
//        failure(error);
//    }];
    
    [request requestWithUrl:ToolsRequest_Url parameters:parameterDic successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
}

@end
