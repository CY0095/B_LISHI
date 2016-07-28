//
//  PostRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostRequest : NSObject
+(instancetype)sharePostRequest;
-(void)postHeadViewRequestWithTopic_id:(NSString *)topic_id user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure;
-(void)postReplyRequestWithTopic_id:(NSString *)topic_id user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
