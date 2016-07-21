//
//  AttentionRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttentionRequest : NSObject
+(instancetype)shareAttentionRequest;
-(void)attentionRequestWithFromuid:(NSString *)fromuid touid:(NSString *)touid success:(SuccessResponse)success failure:(FailureResponse)failure;


@end
