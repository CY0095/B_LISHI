//
//  LoginRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "LoginRequest.h"
static LoginRequest *request = nil;
@implementation LoginRequest
+(instancetype)shareLoginRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}


-(void)loginRequestWithUsername:(NSString *)username passWord:(NSString *)passWord success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:loginRequest_Url paramters:@{@"mobile" : username, @"passwd" : passWord} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
