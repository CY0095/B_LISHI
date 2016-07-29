//
//  OutDoorShopRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/29.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "OutDoorShopRequest.h"

@implementation OutDoorShopRequest

-(void)outDoorShopRequestWithParameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    
    [request requestWithUrl:outDoorShopRequest_Url parameters:parameterDic successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
}

@end
