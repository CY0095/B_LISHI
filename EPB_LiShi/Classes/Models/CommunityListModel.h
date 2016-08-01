//
//  CommunityListModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface CommunityListModel : BaseModel

// 不知名的ID
@property (nonatomic, copy) NSString *ID;
// 用户ID
@property (nonatomic, copy) NSString *user_id;
// 昵称
@property (nonatomic, copy) NSString *nickname;
// 头像
@property (nonatomic, copy) NSString *headicon;
// 列表ID
@property (nonatomic, copy) NSString *topic_id;
// 标题
@property (nonatomic, copy) NSString *title;
// 回复数量
@property (nonatomic, copy) NSString *reply_num;
// 活动封面
@property (nonatomic, copy) NSString *image;
// 类型
@property (nonatomic, assign) NSInteger type;
// Url
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger attenStatus;
@end
