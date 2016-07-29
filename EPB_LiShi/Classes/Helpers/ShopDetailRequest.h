//
//  ShopDetailRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface ShopDetailRequest : BaseRequest

- (void)shopRequestWithId:(NSString *)Id User_id:(NSString *)user_id sucess:(SuccessResponse)sucess failure:(FailureResponse)failure;

@end
