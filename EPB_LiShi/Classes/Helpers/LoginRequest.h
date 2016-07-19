//
//  LoginRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequest : NSObject
+(instancetype)shareLoginRequest;
-(void)loginRequestWithUsername:(NSString *)username passWord:(NSString *)passWord success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
