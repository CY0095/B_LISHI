//
//  FlClothRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "FlClothRequest.h"

@implementation FlClothRequest

- (void)flClothRequestWithTopID:(NSString *)TopID userID:(NSString *)userID sucess:(SuccessResponse)sucess failure:(FailureResponse)failure;
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    [request sendDataWithUrl:flClothClothDetailRequest_Url paramters:@{@"topic_id" : TopID,@"user_id": userID} successResponse:^(NSDictionary *dic) {
        
        sucess(dic);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

@end
