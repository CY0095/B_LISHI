//
//  BuySportRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface BuySportRequest : BaseRequest

- (void)buySportClothRequestWithParameter:(NSDictionary *)parameter sucess:(SuccessResponse)sucess failure:(FailureResponse)failure;

@end
