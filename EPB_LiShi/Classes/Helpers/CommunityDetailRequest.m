//
//  CommunityDetailRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityDetailRequest.h"
#import "NetWorkRequest.h"


@implementation CommunityDetailRequest
- (void)CommunityDetailRequestWithTopics_id:(NSString *)topics_id
                                    user_id:(NSString *)user_id
                                   success:(SuccessResponse)success
                                   failure:(FailureResponse)failure {
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    [request sendDataWithUrl:CommunityListDetailRequest_Url paramters:@{@"topics_id":topics_id,@"user_id":user_id} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
@end
