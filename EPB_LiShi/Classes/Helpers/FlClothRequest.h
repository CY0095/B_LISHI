//
//  FlClothRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface FlClothRequest : BaseRequest

- (void)flClothRequestWithTopID:(NSString *)TopID userID:(NSString *)userID sucess:(SuccessResponse)sucess failure:(FailureResponse)failure;

@end
