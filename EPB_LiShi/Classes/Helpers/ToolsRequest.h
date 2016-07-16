//
//  ToolsRequest.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkRequest.h"

@interface ToolsRequest : NSObject

-(void)ToolsRequestWithParameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure;

@end
