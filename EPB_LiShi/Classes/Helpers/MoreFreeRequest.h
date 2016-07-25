//
//  MoreFreeRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface MoreFreeRequest : BaseRequest

- (void)moreFreeRequestWithTagID:(NSString *)TagID sucess:(SuccessResponse)sucess failure:(FailureResponse)failure;

@end
