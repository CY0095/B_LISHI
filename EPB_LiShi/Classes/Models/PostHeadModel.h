//
//  PostHeadModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface PostHeadModel : BaseModel
@property(strong,nonatomic)NSString *topic_id;// 话题ID
@property(strong,nonatomic)NSString *title;// 标题
@property(strong,nonatomic)NSArray *topic_image;// 图片
@property(strong,nonatomic)NSString *user_id;// 楼主ID
@property(strong,nonatomic)NSString *nickname;// 昵称
@property(strong,nonatomic)NSString *headicon;// 头像
@property(assign,nonatomic)NSInteger category;// 类型
@property(strong,nonatomic)NSString *content;// 内容
@property(strong,nonatomic)NSString *createdate;// 创建时间
@property(assign,nonatomic)NSInteger visits;// 访问量
@end
