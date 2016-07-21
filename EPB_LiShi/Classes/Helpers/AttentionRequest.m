//
//  AttentionRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "AttentionRequest.h"
static AttentionRequest *request = nil;
@implementation AttentionRequest
+(instancetype)shareAttentionRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}
-(void)attentionRequestWithFromuid:(NSString *)fromuid touid:(NSString *)touid success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:attentionRequest_Url paramters:@{@"fromuid":fromuid,@"touid":touid} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
