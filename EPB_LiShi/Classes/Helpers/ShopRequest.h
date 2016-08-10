//
//  ShopRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface ShopRequest : BaseRequest

- (void)shopRequestWithNumber:(NSString *) number Brand_id:(NSString *)Brand_id Latitude:(NSString *)latitude Longitude:(NSString *)longitude sucess:(SuccessResponse)sucess failure:(FailureResponse)failure;

@end
