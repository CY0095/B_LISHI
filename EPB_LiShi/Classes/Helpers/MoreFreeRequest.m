//
//  MoreFreeRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MoreFreeRequest.h"

@implementation MoreFreeRequest

- (void)moreFreeRequestWithTagID:(NSString *)TagID sucess:(SuccessResponse)sucess failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    [request sendDataWithUrl:moreFreeClothDetailRequest_Url paramters:@{@"tagid" : TagID} successResponse:^(NSDictionary *dic) {
        
        sucess(dic);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

@end
