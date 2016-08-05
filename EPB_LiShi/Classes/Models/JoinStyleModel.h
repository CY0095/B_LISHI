//
//  JoinStyleModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface JoinStyleModel : BaseModel

//活动时间
@property (strong, nonatomic) NSString *times;
//获得奖品的照片
@property (strong, nonatomic) NSString *awardFileUrl;
//获得奖品的照片高度
@property (assign, nonatomic) NSInteger award_height;
//参与方式
@property (strong, nonatomic) NSString *activeDesc;
//参与活动的晒出的图片
@property (strong, nonatomic) NSString *activeFileUrl;
//活动图片的高度
@property (assign, nonatomic) NSInteger active_height;
//活动奖品
@property (strong, nonatomic) NSString *activeAward;


@end
