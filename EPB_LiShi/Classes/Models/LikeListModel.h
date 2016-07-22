//
//  LikeListModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface LikeListModel : BaseModel

//用户的头像
@property (strong, nonatomic) NSString *headicon;
//用户的ID
@property (strong, nonatomic) NSString *userID;
//是否为VIP
@property (assign, nonatomic) NSInteger is_vip;
//用户的昵称
@property (strong, nonatomic) NSString *nickname;

@end
