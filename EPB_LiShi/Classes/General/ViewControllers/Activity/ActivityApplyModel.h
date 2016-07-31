//
//  ActivityApplyModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/31.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityApplyModel : BaseModel
@property(strong,nonatomic)NSString *activityID;
@property(strong,nonatomic)NSString *user_id;
@property(strong,nonatomic)NSString *activityTitle;
@property(strong,nonatomic)NSString *imageStr;
@end
