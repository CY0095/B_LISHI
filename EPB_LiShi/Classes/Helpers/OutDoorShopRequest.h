//
//  OutDoorShopRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/29.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface OutDoorShopRequest : BaseRequest

-(void)outDoorShopRequestWithParameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure;

@end
