//
//  UserDetailRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "UserDetailRequest.h"
static UserDetailRequest *request = nil;
@implementation UserDetailRequest
+(instancetype)shareUserDetailRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}
-(void)UserDetailRequestWithUid:(NSString *)uid user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:userDetailRequest_Url paramters:@{@"uid":uid,@"user_id":user_id} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



@end
