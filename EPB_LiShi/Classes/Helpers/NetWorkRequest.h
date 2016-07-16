//
//  NetWorkRequest.h
//  Lesson项目A_豆瓣
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseRequest.h"
typedef void(^SuccessResponse)(NSDictionary *dic);
typedef void(^FailureResponse)(NSError *error);

@interface NetWorkRequest : BaseRequest
-(void)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameterDic successResponse:(SuccessResponse)success failureResponse:(FailureResponse)fail;



-(void)sendDataWithUrl:(NSString *)url paramters:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failure:(FailureResponse)failure;


-(void)sendImageWithUrl:(NSString *)url paramter:(NSDictionary *)paramterDic image:(UIImage *)uploadImage successResponse:(SuccessResponse)success failureResponse:(FailureResponse)failure;

@end
