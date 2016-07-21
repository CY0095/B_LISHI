//
//  MyAttentionModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface MyAttentionModel : BaseModel
@property(strong,nonatomic)NSString *headicon;// 用户头像
@property(assign,nonatomic)BOOL is_vip;// 是否为vip
@property(strong,nonatomic)NSString *nickname;// 昵称
@property(strong,nonatomic)NSString *topic_title;// 标题
@property(strong,nonatomic)NSString *user_id;// 用户ID

@end
