//
//  UpMydataRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpMydataRequest : NSObject
+(instancetype)shareUpmyDataRequest;
-(void)upMydataWithNickname:(NSString *)nickname user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure;
-(void)upMydataWithImage:(UIImage *)image user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
