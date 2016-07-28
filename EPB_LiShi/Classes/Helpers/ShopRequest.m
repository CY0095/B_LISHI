//
//  ShopRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopRequest.h"

@implementation ShopRequest

- (void)shopRequestWithBrand_id:(NSString *)Brand_id Latitude:(NSString *)latitude Longitude:(NSString *)longitude sucess:(SuccessResponse)sucess failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:shopRequest_Url paramters:@{@"brand_id" : Brand_id,@"latitude" : latitude,@"longitude" : longitude} successResponse:^(NSDictionary *dic) {
        
        sucess(dic);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

@end
