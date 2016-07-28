//
//  ShopDetailRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopDetailRequest.h"

@implementation ShopDetailRequest

- (void)shopRequestWithId:(NSString *)Id User_id:(NSString *)user_id sucess:(SuccessResponse)sucess failure:(FailureResponse)failure
{
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:shopDetailRequest_Url parameters:@{@"id":Id,@"user_id":user_id} successResponse:^(NSDictionary *dic) {
        
        sucess(dic);
    } failureResponse:^(NSError *error) {
        
        failure(error);
    }];
    
    
}

@end
