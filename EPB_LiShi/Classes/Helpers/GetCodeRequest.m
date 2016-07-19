//
//  GetCodeRequest.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "GetCodeRequest.h"
static GetCodeRequest *request = nil;
@implementation GetCodeRequest
+(instancetype)shareGetCodeRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}
-(void)getCodeRequestWithphoneNumber:(NSString *)phoneNumber success:(SuccessResponse)success failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request sendDataWithUrl:getCodeRequest_Url paramters:@{@"mobile" : phoneNumber} successResponse:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
