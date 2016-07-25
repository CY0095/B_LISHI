//
//  PostMessageModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface PostMessageModel : BaseModel
@property(strong,nonatomic)NSString *activity_code;
@property(strong,nonatomic)NSString *club_id;
@property(assign,nonatomic)NSInteger category;// 种类
@property(strong,nonatomic)NSString *club_title;// 来自...
@property(strong,nonatomic)NSString *createdate;// 创建日期
@property(assign,nonatomic)NSInteger height;
@property(assign,nonatomic)NSInteger width;
@property(strong,nonatomic)NSString *image;// 图片
@property(strong,nonatomic)NSString *topic_id;
@property(strong,nonatomic)NSString *topic_title;// 标题

@end
