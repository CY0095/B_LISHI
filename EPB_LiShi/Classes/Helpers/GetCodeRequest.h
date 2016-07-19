//
//  GetCodeRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCodeRequest : NSObject
+(instancetype)shareGetCodeRequest;
-(void)getCodeRequestWithphoneNumber:(NSString *)phoneNumber success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
