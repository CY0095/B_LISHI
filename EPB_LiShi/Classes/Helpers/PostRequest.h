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
-(void)postReplyRequestWithTopic_id:(NSString *)topic_id user_id:(NSString *)user_id page:(NSString *)page success:(SuccessResponse)success failure:(FailureResponse)failure;
-(void)replyRequestWithUser_id:(NSString *)user_id club_id:(NSString *)club_id parentid:(NSString *)parentid reply_id:(NSString *)reply content:(NSString *)content success:(SuccessResponse)success failure:(FailureResponse)failure;

-(void)postMessageRequestWithUser_id:(NSString *)user_id content:(NSString *)content title:(NSString *)title data:(NSData *)data success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
