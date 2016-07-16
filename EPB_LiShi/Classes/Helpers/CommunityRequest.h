//
//  CommunityRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetWorkRequest.h"
@interface CommunityRequest : NSObject
- (void)CommunityListRequestWithParameter:(NSDictionary *)parameterDic
                             success:(SuccessResponse)success
                             failure:(FailureResponse)failure;
@end
