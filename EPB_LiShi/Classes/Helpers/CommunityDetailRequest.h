//
//  CommunityDetailRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseRequest.h"

@interface CommunityDetailRequest : BaseRequest
- (void)CommunityDetailRequestWithTopics_id:(NSString *)topics_id
                                    user_id:(NSString *)user_id
                                    success:(SuccessResponse)success
                                    failure:(FailureResponse)failure;
@end
