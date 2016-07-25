//
//  TopicDetailRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "TopicDetailRequest.h"
static TopicDetailRequest *request = nil;
@implementation TopicDetailRequest
+(instancetype)shareTopicDetailRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}
-(void)topicDetailRequestWithTopics_id:(NSString *)topics_id user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:topicsDetailRequest_Url paramters:@{@"topics_id" : topics_id ,@"user_id" : user_id} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)commentRequestWithContent:(NSString *)content topics_id:(NSString *)topics_id user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:commentRequest_Url paramters:@{@"content":content,@"topics_id":topics_id,@"user_id":user_id} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
@end
