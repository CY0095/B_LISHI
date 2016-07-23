//
//  TopicDetailRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicDetailRequest : NSObject
+(instancetype)shareTopicDetailRequest;
-(void)topicDetailRequestWithTopics_id:(NSString *)topics_id user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure;

-(void)commentRequestWithContent:(NSString *)content topics_id:(NSString *)topics_id user_id:(NSString *)user_id success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
