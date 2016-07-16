//
//  CommunityRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityRequest.h"
// 社区列表
#define CommunityListRequest_Url @"http://api.lis99.com/v4/club/omnibusList/0/451316"
@implementation CommunityRequest
- (void)CommunityListRequestWithParameter:(NSDictionary *)parameterDic
                                  success:(SuccessResponse)success
                                  failure:(FailureResponse)failure {
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:CommunityListRequest_Url parameters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
    
}
@end
