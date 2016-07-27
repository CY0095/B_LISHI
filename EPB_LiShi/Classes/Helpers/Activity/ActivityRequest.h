//
//  ActivityRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityRequest : NSObject


-(void)ActivityRequestParameter:(NSDictionary *)paramerter success:(SuccessResponse)success failure:(FailureResponse)failure;


-(void)ActivityRequestWithLongitude:(NSString *)longitude latitude:(NSString *)latitude parameter:(NSDictionary *)paramerter success:(SuccessResponse)success failure:(FailureResponse)failure;



@end
