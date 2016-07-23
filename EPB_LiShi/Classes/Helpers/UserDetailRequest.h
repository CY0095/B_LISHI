//
//  UserDetailRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailRequest : NSObject
+(instancetype)shareUserDetailRequest;
-(void)UserDetailRequestWithUid:(NSString *)uid user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure;


@end
