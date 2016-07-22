//
//  EquipDetailRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"
#import "NetWorkRequest.h"

@interface EquipDetailRequest : BaseModel

- (void)equipDetailRequestWithParameter:(NSDictionary *)parameter sucess:(SuccessResponse)sucess failure:(FailureResponse)failure;

@end
