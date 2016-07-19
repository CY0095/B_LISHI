//
//  UpMydataRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "UpMydataRequest.h"
static UpMydataRequest *request = nil;
@implementation UpMydataRequest
+(instancetype)shareUpmyDataRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}


-(void)upMydataWithNickname:(NSString *)nickname user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:changeNickNameRequest_Url paramters:@{@"nickname":nickname,@"user_id":user_id} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)upMydataWithImage:(UIImage *)image success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendImageWithUrl:getHeadImgRequest_Url paramter:nil image:image successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

@end
