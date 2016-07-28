//
//  BuySportRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BuySportRequest.h"

@implementation BuySportRequest

- (void)buySportClothRequestWithParameter:(NSDictionary *)parameter sucess:(SuccessResponse)sucess failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    NSString *ID = [parameter objectForKey:@"id"];
    [request requestWithUrl:buySportClothDetailRequest_Url(ID) parameters:nil successResponse:^(NSDictionary *dic) {
        
        sucess(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
}

@end
