//
//  RegisterRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "RegisterRequest.h"
static RegisterRequest *request = nil;
@implementation RegisterRequest
+(instancetype)shareRegisterRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}

-(void)registerRequestWithUsername:(NSString *)username passWord:(NSString *)passWord code:(NSString *)code success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:registerRequest_Url paramters:@{@"code" : code, @"mobile" : username, @"passwd" : passWord} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
