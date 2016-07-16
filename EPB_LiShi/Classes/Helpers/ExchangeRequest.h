//
//  ExchangeRequest.h
//  tools
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkRequest.h"

@interface ExchangeRequest : NSObject

-(void)ExchangeRequestWithParameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure;

@end
