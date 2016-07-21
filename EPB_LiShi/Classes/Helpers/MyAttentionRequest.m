//
//  MyAttentionRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MyAttentionRequest.h"
static MyAttentionRequest *request = nil;
@implementation MyAttentionRequest
+(instancetype)shareMyAttentionRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}
-(void)myAttentRequestWithUid:(NSString *)uid success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:myAttentionRequest_Url paramters:@{@"uid":uid} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
