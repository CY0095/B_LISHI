//
//  NetWorkRequest.m
//  Lesson项目A_豆瓣
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "NetWorkRequest.h"



@implementation NetWorkRequest

// GET请求
-(void)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameterDic successResponse:(SuccessResponse)success failureResponse:(FailureResponse)fail{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:url parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

// POST请求
-(void)sendDataWithUrl:(NSString *)url paramters:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failure:(FailureResponse)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/x-www-form-urlencoded"];
    [manager POST:url parameters:paramterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}


// 上传图片
-(void)sendImageWithUrl:(NSString *)url paramter:(NSDictionary *)paramterDic image:(UIImage *)uploadImage successResponse:(SuccessResponse)success failureResponse:(FailureResponse)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paramterDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(uploadImage, 0.5) name:@"avatar" fileName:@"avatar.jpg" mimeType:@"application/octet-stream"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}


@end
