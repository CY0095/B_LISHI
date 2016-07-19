//
//  RegisterRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterRequest : NSObject
+(instancetype)shareRegisterRequest;
-(void)registerRequestWithUsername:(NSString *)username passWord:(NSString *)passWord code:(NSString *)code success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
