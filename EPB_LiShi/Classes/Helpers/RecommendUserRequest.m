//
//  RecommendUserRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "RecommendUserRequest.h"
static RecommendUserRequest *request = nil;
@implementation RecommendUserRequest
+(instancetype)shareRecomendUserRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}
-(void)recommendUserWithUid:(NSString *)uid Success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:recommendUserRequest_Url paramters:@{@"uid":uid} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
