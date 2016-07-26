//
//  CommunityRequest.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetWorkRequest.h"
@interface CommunityRequest : NSObject
- (void)CommunityListRequestWithParameter:(NSDictionary *)parameterDic
                             success:(SuccessResponse)success
                             failure:(FailureResponse)failure;
// 徒步露营
- (void)CommunityLuyingListRequestWithParameter:(NSDictionary *)parameterDic
                                        success:(SuccessResponse)success
                                        failure:(FailureResponse)failure;
// 户外摄影
- (void)CommunitySheyingListRequestWithParameter:(NSDictionary *)parameterDic
                                         success:(SuccessResponse)success
                                         failure:(FailureResponse)failure;
// 极限攀岩
- (void)CommunityPandengListRequestWithParameter:(NSDictionary *)parameterDic
                                         success:(SuccessResponse)success
                                         failure:(FailureResponse)failure;
// 装备控
- (void)CommunityZhuangbeikongListRequestWithParameter:(NSDictionary *)parameterDic
                                               success:(SuccessResponse)success
                                               failure:(FailureResponse)failure;
// 户外范
- (void)CommunityHuwaifanListRequestWithParameter:(NSDictionary *)parameterDic
                                                success:(SuccessResponse)success
                                                failure:(FailureResponse)failure;
// 板块介绍
- (void)CommunityHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                        success:(SuccessResponse)success
                                        failure:(FailureResponse)failure;
- (void)SheyingHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                      success:(SuccessResponse)success
                                      failure:(FailureResponse)failure;
- (void)PandengHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                      success:(SuccessResponse)success
                                      failure:(FailureResponse)failure;
- (void)ZhuangbeikongHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                            success:(SuccessResponse)success
                                            failure:(FailureResponse)failure;
- (void)HuwaifanHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                       success:(SuccessResponse)success
                                       failure:(FailureResponse)failure;
- (void)CollectionViewCellRequestWithParameter:(NSDictionary *)parameterDic
                                       success:(SuccessResponse)success
                                       failure:(FailureResponse)failure;
- (void)CommunityAllListViewRequestWithParameter:(NSDictionary *)parameterDic
                                         success:(SuccessResponse)success
                                         failure:(FailureResponse)failure;
- (void)CommunityAllListHeaderViewRequestWithParameter:(NSDictionary *)parameterDic
                                               success:(SuccessResponse)success
                                               failure:(FailureResponse)failure;
@end
