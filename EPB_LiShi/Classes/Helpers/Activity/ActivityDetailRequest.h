//
//  ActivityDetailRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetailRequest : NSObject

-(void)ActivityDetailRequestParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure;


-(void)ActivityDetailRequestTwoParameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure;


-(void)ActivityDetailRequestWithUrl:(NSString *)url Parameter:(NSDictionary *)parameter success:(SuccessResponse)success failure:(FailureResponse)failure;


@end
