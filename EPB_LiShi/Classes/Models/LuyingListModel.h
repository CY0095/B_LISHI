//
//  LuyingListModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface LuyingListModel : BaseModel
// 列表ID
@property (nonatomic, copy) NSString *list_id;
// 用户ID
@property (nonatomic, copy) NSString *user_id;
// 昵称
@property (nonatomic, copy) NSString *nickname;
// 头像
@property (nonatomic, copy) NSString *headicon;
// 标题
@property (nonatomic, copy) NSString *title;
// 内容
@property (nonatomic, copy) NSString *content;
// 更新时间
@property (nonatomic, copy) NSString *update_time;
// 点赞数量
@property (nonatomic, assign) NSInteger likeNum;
// 图片
@property (nonatomic, copy) NSArray *images;
// 视频封面
@property (nonatomic, copy) NSString *videoimg;
// 视频ID
@property (nonatomic, assign) NSInteger videoid;


@end
