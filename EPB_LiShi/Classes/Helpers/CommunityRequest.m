//
//  CommunityRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityRequest.h"


@implementation CommunityRequest
- (void)CommunityListRequestWithParameter:(NSDictionary *)parameterDic
                                  success:(SuccessResponse)success
                                  failure:(FailureResponse)failure {
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *page = [parameterDic objectForKey:@"page"];
    [request requestWithUrl:CommunityListRequest_Url(page) parameters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
    
}
- (void)CommunityLuyingListRequestWithParameter:(NSDictionary *)parameterDic
                                        success:(SuccessResponse)success
                                        failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *page = [parameterDic objectForKey:@"page"];
    NSString *user_id = [parameterDic objectForKey:@"user_id"];
    [request requestWithUrl:CommunityLuyingListRequest_Url(page, user_id) parameters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
- (void)CommunitySheyingListRequestWithParameter:(NSDictionary *)parameterDic
                                         success:(SuccessResponse)success
                                         failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *page = [parameterDic objectForKey:@"page"];
    NSString *user_id = [parameterDic objectForKey:@"user_id"];
    [request requestWithUrl:CommunitySheyingListRequest_Url(page, user_id) parameters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
- (void)CommunityPandengListRequestWithParameter:(NSDictionary *)parameterDic
                                         success:(SuccessResponse)success
                                         failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *page = [parameterDic objectForKey:@"page"];
    NSString *user_id = [parameterDic objectForKey:@"user_id"];
    [request requestWithUrl:CommunityPandengListRequest_Url(page, user_id) parameters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

- (void)CommunityZhuangbeikongListRequestWithParameter:(NSDictionary *)parameterDic
                                               success:(SuccessResponse)success
                                               failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:CommunityZhuangbeikongListRequest_Url parameters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}
- (void)CommunityHuwaifanListRequestWithParameter:(NSDictionary *)parameterDic
                                          success:(SuccessResponse)success
                                          failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *page = [parameterDic objectForKey:@"page"];
    NSString *user_id = [parameterDic objectForKey:@"user_id"];
    [request requestWithUrl:CommunityHuwaifanListRequest_Url(page, user_id) parameters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}
// 板块介绍
- (void)CommunityHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                        success:(SuccessResponse)success
                                        failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:LuyingHeaderViewRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}
- (void)SheyingHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                      success:(SuccessResponse)success
                                      failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:SheyingHeaderViewRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}
- (void)PandengHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                      success:(SuccessResponse)success
                                      failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:PandengHeaderViewRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
- (void)ZhuangbeikongHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                            success:(SuccessResponse)success
                                            failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:ZhuangbeikongHeaderViewRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
- (void)HuwaifanHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                       success:(SuccessResponse)success
                                       failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:HuwaifanHeaderViewRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
- (void)CollectionViewCellRequestWithParameter:(NSDictionary *)parameterDic
                                       success:(SuccessResponse)success
                                       failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:CommunityAllCollectionViewRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
    
}

- (void)CommunityAllListViewRequestWithParameter:(NSDictionary *)parameterDic
                                         success:(SuccessResponse)success
                                         failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *club_id = [parameterDic objectForKey:@"club_id"];
    NSString *user_id = [parameterDic objectForKey:@"user_id"];
    [request requestWithUrl:CommunityAllListRequest_Url(club_id, user_id) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
- (void)CommunityAllListHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                               success:(SuccessResponse)success
                                               failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *club_id = [parameterDic objectForKey:@"club_id"];
    NSString *user_id = [parameterDic objectForKey:@"user_id"];
    [request requestWithUrl:CommunityAllListHeaderRequest_Url(club_id, user_id) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

- (void)CommunityHeaderDetailViewRequestWithParameter:(NSDictionary *)parameterDic
                                              success:(SuccessResponse)success
                                              failure:(FailureResponse)failure {
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *club_id = [parameterDic objectForKey:@"club_id"];
    NSString *user_id = [parameterDic objectForKey:@"user_id"];
    [request requestWithUrl:CommunityHeaderDetailRequest_Url(club_id, user_id) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}


@end
