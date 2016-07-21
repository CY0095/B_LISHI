//
//  RecommendUserRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendUserRequest : NSObject
+(instancetype)shareRecomendUserRequest;
-(void)recommendUserWithUid:(NSString *)uid Success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
