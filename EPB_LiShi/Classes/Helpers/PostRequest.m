//
//  PostRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "PostRequest.h"
static PostRequest *request = nil;
@implementation PostRequest
+(instancetype)sharePostRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}
-(void)postHeadViewRequestWithTopic_id:(NSString *)topic_id user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:postHeadRequest_Url(topic_id, user_id) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
-(void)postReplyRequestWithTopic_id:(NSString *)topic_id user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:postReplyRequest_Url(topic_id, user_id) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

@end
