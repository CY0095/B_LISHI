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
-(void)postReplyRequestWithTopic_id:(NSString *)topic_id user_id:(NSString *)user_id page:(NSString *)page success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:postReplyRequest_Url(topic_id, user_id,page) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
-(void)replyRequestWithUser_id:(NSString *)user_id club_id:(NSString *)club_id parentid:(NSString *)parentid reply_id:(NSString *)reply content:(NSString *)content success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:replyRequest_Url paramters:@{@"user_id":user_id,@"club_id":club_id,@"parentid":parentid,@"reply_id":reply,@"content":content} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


-(void)postMessageRequestWithUser_id:(NSString *)user_id content:(NSString *)content title:(NSString *)title data:(NSData *)data success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:postMessageRequest_Url paramters:@{@"club_id":@"48",@"content[]":content,@"source":@"2",@"title":title,@"user_id":user_id,@"ext[]":@".JPEG",@"thumb[]":data} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
